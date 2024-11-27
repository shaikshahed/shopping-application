// import 'package:bloc/bloc.dart';
// import 'package:frontend/user_register_repo/register_repo.dart';
// import 'package:meta/meta.dart';

// part 'brand_event.dart';
// part 'brand_state.dart';

// class BrandBloc extends Bloc<BrandEvent, BrandState> {
//   BrandBloc() : super(BrandInitialState()) {
//     on<FetchBrandItemsEvent>((event, emit) async{
//       emit(BrandLoadingState());
//       try{
//         final data = await UserRepository().fetchBrandItems(event.brandName);
//         emit(BrandLoadedState(item: data));
//       }catch(e){
//         emit(BrandErrorState(message: e.toString()));
//       }
//     });
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:frontend/user_register_repo/register_repo.dart';
import 'package:meta/meta.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  BrandBloc() : super(BrandInitialState()) {
    on<FetchBrandItemsEvent>((event, emit) async {
      emit(BrandLoadingState());
      try {
        final data = await UserRepository().fetchBrandItems(event.brandName);

        // Separating clothing and footwear items
        final clothingItems = data
            .where((category) => category['type'] == 'clothing')
            .map((category) => category['items'])
            .expand((item) => item)
            .toList();

        final footwearItems = data
            .where((category) => category['type'] == 'footwear')
            .map((category) => category['items'])
            .expand((item) => item)
            .toList();

        emit(BrandLoadedState(clothingItems: clothingItems, footwearItems: footwearItems));
      } catch (e) {
        emit(BrandErrorState(message: e.toString()));
      }
    });
  }
}
