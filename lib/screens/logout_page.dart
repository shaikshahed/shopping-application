import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/logout_bloc/logout_bloc.dart';
import 'package:frontend/user/login_page.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            BlocProvider.of<LogoutBloc>(context).add(LogoutRequested());
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
