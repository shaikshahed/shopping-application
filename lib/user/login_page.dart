import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/login_bloc/user_login_bloc.dart';
import 'package:frontend/register_bloc/user_register_bloc.dart';
import 'package:frontend/screens/bottom_navigation_bar.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/user/register_page.dart';
import 'package:frontend/user_register_repo/register_repo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final UserRepository userRepository = UserRepository();
  bool _isPasswordVisible = false;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
       create: (providerContext) {
          return UserLoginBloc(UserRepository());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.2), // Add some top space
                  // Title and subtitle
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Please login to continue",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  // Username Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Username",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your username";
                          }
                          return null;
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Enter your username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Password",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          } else if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                        controller: passwordController,
                        obscureText:
                            !_isPasswordVisible, 
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Forgot Password Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Handle forgot password
                          },
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  // Login Button
                  BlocConsumer<UserLoginBloc, UserLoginState>(
                    listener: (context, state) {
                      if (state is UserLoginSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Login Successful!")));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomBarTabs()));
                      } else if (state is UserLoginFailureState) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(state.error)));
                      }
                    },
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: state is UserLoginLoadingState
                              ? null
                              : () {
                                  if (_formkey.currentState!.validate()) {
                                    BlocProvider.of<UserLoginBloc>(context).add(
                                        LoginButtonPressed(
                                            email: emailController.text,
                                            password: passwordController.text));
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: state is UserLoginLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const Text(
                                  "Login",
                                  style: TextStyle(fontSize: 20),
                                ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have account?"),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage(userRepository: userRepository)));
                      }, child: Text("Register"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
