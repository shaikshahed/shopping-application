part of 'user_login_bloc.dart';

abstract class UserLoginState{}

class UserLoginInitialState extends UserLoginState{}

class UserLoginLoadingState extends UserLoginState{}

class UserLoginSuccessState extends UserLoginState{}

class UserLoginFailureState extends UserLoginState{
  final String error;

  UserLoginFailureState({required this.error});
}
