import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/register_bloc/user_register_bloc.dart';
import 'package:frontend/screens/bottom_navigation_bar.dart';
import 'package:frontend/user/login_page.dart';
import 'package:frontend/user/register_page.dart';
import 'package:frontend/user_register_repo/register_repo.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserRepository userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Function to check if user_id is present in SharedPreferences
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('user_id'); // Get user ID

    Future.delayed(const Duration(seconds: 3), () {
      if (userId != null && userId.isNotEmpty) {
        // If user_id is present, navigate to BottomBarTabs
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomBarTabs(), // Navigate to home page with bottom tabs
          ),
        );
      } else {
        // If user_id is not present, navigate to LoginPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#dfe3f8"),
      body: Center(
        child: Image.asset("assets/splash_screen.webp"),
      ),
    );
  }
}
