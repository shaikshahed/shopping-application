part of 'user_register_bloc.dart';

abstract class UserRegisterState{}

class UserRegisterInitial extends UserRegisterState{}

class UserRegisterLoading extends UserRegisterState{}

class UserRegisterSuccess extends UserRegisterState{}

class UserRegisterFailure extends UserRegisterState{
  final String error;

  UserRegisterFailure({required this.error});
}
