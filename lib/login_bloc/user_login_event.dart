part of 'user_login_bloc.dart';

abstract class UserLoginEvent{}

class LoginButtonPressed extends UserLoginEvent{
  final String email;
  final String password;

  LoginButtonPressed({
    required this.email,
    required this.password
  });
}

