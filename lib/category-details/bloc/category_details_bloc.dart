import 'package:bloc/bloc.dart';
import 'package:frontend/category_screen/bloc/category_bloc.dart';
import 'package:frontend/user_register_repo/register_repo.dart';
import 'package:meta/meta.dart';

part 'category_details_event.dart';
part 'category_details_state.dart';

class CategoryDetailsBloc extends Bloc<CategoryDetailsEvent, CategoryDetailsState> {
  CategoryDetailsBloc() : super(CategoryDetailsInitialState()) {
    on<FetchCategoryDetailsEvent>((event, emit) async {
      emit(CategoryDetailsLoadingState());
      try{
        final data = await UserRepository().fetchCategoryDetailData(event.category,event.categoryId);
        emit(CategoryDetailsLoadedState(item: data));
      }catch(e){
        emit(CategoryDetailsErrorState(message: e.toString()));
      }
    });
  }
}
