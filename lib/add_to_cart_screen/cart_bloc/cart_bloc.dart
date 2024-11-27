import 'package:bloc/bloc.dart';
import 'package:frontend/user_register_repo/register_repo.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddToCartEvent>((event, emit) async {
      emit(CartLoading());
      try {
        await UserRepository().addToCart(event.userId, event.item);
        emit(CartLoaded(message: 'Item added successfully'));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<GetCartItemsEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();

      emit(CartLoading());
      try {
        final items = await UserRepository()
            .getCartItems(prefs.getString("user_id").toString());
        emit(GetCartLoaded(cartItems: items));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
    on<RemoveFromCartEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      emit(CartLoading());
      try {
        await UserRepository().removeSingleItemFromCart(
            prefs.getString("user_id").toString(), event.itemId);
            print("useriddd:${prefs.getString("user_id").toString()}");
            print("itemidddd:${event.itemId}");
            emit(ItemRemoved(message: "Item removed successfully."));
        // Optionally reload cart items after removal
        final updatedItems = await UserRepository().getCartItems(prefs.getString("user_id").toString());
        emit(GetCartLoaded(cartItems: updatedItems));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
  }
}
