// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:frontend/user_register_repo/register_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_login_event.dart';
part 'user_login_state.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  final UserRepository userRepository;
  
  UserLoginBloc(this.userRepository) : super(UserLoginInitialState()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(UserLoginLoadingState());
      try {
        final userId = await userRepository.loginUser(
          email: event.email,
          password: event.password,
        );

        // Store userId in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        if (userId != null) {
          await prefs.setString('user_id', userId);
        }
        print("userId:$userId");
        emit(UserLoginSuccessState());
      } catch (error) {
        emit(UserLoginFailureState(error: error.toString()));
      }
    });
  }
}