import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/category-details/category_details.dart';
import 'package:frontend/category_screen/category_grid_screen.dart';
import 'package:frontend/category_screen/category_names_screen.dart';
import 'package:frontend/login_bloc/user_login_bloc.dart';
import 'package:frontend/screens/bottom_navigation_bar.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/music_screen.dart';
import 'package:frontend/screens/new_arrival_screen.dart';
import 'package:frontend/splash_screen.dart';
import 'package:frontend/user/login_page.dart';
import 'package:frontend/user/register_page.dart';
import 'package:frontend/user_register_repo/register_repo.dart';
import 'package:frontend/register_bloc/user_register_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

      ),
      home: MultiBlocProvider(
        providers: [
           BlocProvider<UserRegisterBloc>(
      create: (BuildContext context) => UserRegisterBloc(userRepository),
    ),
         BlocProvider<UserLoginBloc>(
      create: (BuildContext context) => UserLoginBloc(userRepository),
    ),
        ],
        // child:const SplashScreen(),
        child: BottomBarTabs()
      ),
    );
  }
}
