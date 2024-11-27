import 'package:bloc/bloc.dart';
import 'package:frontend/user_register_repo/register_repo.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitialState())  {
    on<FetchCategoryEvent>((event, emit) async {
      emit(CategoryLoadingState());
      try{
        final data = await UserRepository().fetchCategoryData(event.category);
        emit(CategoryLoadedState(categoryData: data));
      }catch(e){
        emit(CategoryErrorState(message: e.toString()));
      }
    });
  }
}
