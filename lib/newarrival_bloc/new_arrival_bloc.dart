import 'package:bloc/bloc.dart';
import 'package:frontend/user_register_repo/register_repo.dart';

part 'new_arrival_event.dart';
part 'new_arrival_state.dart';

class NewArrivalBloc extends Bloc<NewArrivalEvent, NewArrivalState> {
  final UserRepository userRepository;
  NewArrivalBloc(this.userRepository) : super(NewArrivalInitialState()) {
    on<FetchNewArrivalItems>((event, emit) async{
      emit(NewArrivalLoadingState());
      try{
        final items = await userRepository.fetchNewArrivalItems();
        emit(NewArrivalLoadedState(items: items));
      }catch(e){
        emit(NewArrivalErrorState(message: "failed to fetch items: ${e.toString()}"));
      }
    });
  }
}
