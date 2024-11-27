import 'package:bloc/bloc.dart';
import 'package:frontend/user_register_repo/register_repo.dart';
import 'package:meta/meta.dart';

part 'brand_details_event.dart';
part 'brand_details_state.dart';

class BrandDetailsBloc extends Bloc<BrandDetailsEvent, BrandDetailsState> {
  BrandDetailsBloc() : super(BrandDetailsInitialState()) {
    on<FetchBrandDetailsEvent>((event, emit) async {
      emit(BrandDetailsLoadingState());
      try{
        final data = await UserRepository().fetchBrandDetailsItem(event.BrandName, event.BrandId);
        emit(BrandDetailsLoadedState(item: data));
      }catch(e){
        emit(BrandDetailsErrorState(message: e.toString()));
      }
    });
  }
}
