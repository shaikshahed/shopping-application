// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import 'package:frontend/user_register_repo/register_repo.dart';

part 'new_arrival_detail_event.dart';
part 'new_arrival_detail_state.dart';

class NewArrivalDetailBloc extends Bloc<NewArrivalDetailEvent, NewArrivalDetailState> {
  final UserRepository userRepository;
  NewArrivalDetailBloc(this.userRepository,) : super(NewArrivalDetailInitial()) {
    on<FetchNewArrivalDetailEvent>((event, emit) async {
      emit(NewArrivalDetailLoadingState());
      try{
        final item = await userRepository.fetchNewArrivalItemId(event.id);
        emit(NewArrivalDetailLoadedState(item: item));
      }catch(e){
        emit(NewArrivalDetailErrorState(message: e.toString()));
      }
    });
  }
}