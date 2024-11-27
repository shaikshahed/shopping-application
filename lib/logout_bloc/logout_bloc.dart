import 'package:bloc/bloc.dart';
import 'package:frontend/user_register_repo/register_repo.dart';
import 'package:meta/meta.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<LogoutRequested>((event, emit) async{
      emit(LogoutInProgress());
      try{
        await UserRepository().logout();
        emit(LogoutSuccess(message: "Logout Successful"));
      }catch(e){
        emit(LogoutFailure(error: "error:$e"));
      }
    });
  }
}
