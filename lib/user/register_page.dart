import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/login_bloc/user_login_bloc.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/user/login_page.dart';
import 'package:frontend/register_bloc/user_register_bloc.dart';
import 'package:frontend/user_register_repo/register_repo.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required userRepository});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (providerContext) {
          return UserRegisterBloc(UserRepository());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Center(
                    child: Column(
                      children: const [
                        Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Please register to continue",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Username",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your username";
                          }
                          return null;
                        },
                        controller: usernameController,
                        decoration: InputDecoration(
                          hintText: "Enter your username",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Email",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Enter your email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Password",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          } else if (value.length < 6) {
                            return "Password should be at least 6 characters";
                          }
                          return null;
                        },
                        controller: passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            icon: Icon(_isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Confirm Password",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please confirm your password";
                          } else if (passwordController.text !=
                              confirmPasswordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        controller: confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              });
                            },
                            icon: Icon(_isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Mobile no.",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your mobile number";
                          }
                          return null;
                        },
                        controller: mobileNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter your mobile number",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const SizedBox(height: 30),
                      BlocConsumer<UserRegisterBloc, UserRegisterState>(
                        listener: (context, state) {
                          if (state is UserRegisterSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Registration successful!')),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          } else if (state is UserRegisterFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is UserRegisterLoading) {
                            return Center(
                                child: const CircularProgressIndicator());
                          }
                          return SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: state is UserRegisterLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        BlocProvider.of<UserRegisterBloc>(
                                                context)
                                            .add(
                                          UserRegisterButtonPressed(
                                            username: usernameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            confirmPassword:
                                                confirmPasswordController.text,
                                            mobileno:
                                                mobileNumberController.text,
                                          ),
                                        );
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: state is UserRegisterLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : const Text(
                                      "Register",
                                      style: TextStyle(fontSize: 20),
                                    ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
