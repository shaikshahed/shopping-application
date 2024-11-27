part of 'user_register_bloc.dart';

abstract class UserRegisterEvent{}

class UserRegisterButtonPressed extends UserRegisterEvent {
  final String username;
  final String password;
  final String email;
  final String confirmPassword;
  final String mobileno;

  UserRegisterButtonPressed({
    required this.username, 
    required this.password, 
    required this.confirmPassword, 
    required this.mobileno, 
    required this.email});
}
