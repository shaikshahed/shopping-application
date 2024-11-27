// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import 'package:frontend/user_register_repo/register_repo.dart';

part 'user_register_event.dart';
part 'user_register_state.dart';

class UserRegisterBloc extends Bloc<UserRegisterEvent, UserRegisterState> {
  final UserRepository userRepository;
  UserRegisterBloc(
    this.userRepository,
  ) : super(UserRegisterInitial()) {
    on<UserRegisterButtonPressed>((event, emit) async{
      emit(UserRegisterLoading());
      try{
        await userRepository.registerUser(
          username: event.username , 
          password: event.password, 
          confirmPassword: event.confirmPassword,
          mobileNo: event.mobileno,
          email: event.email
        );
        emit(UserRegisterSuccess());
      }catch(error){
        emit(UserRegisterFailure(error: error.toString()));
      }
    });
  }
}
