part of 'cart_bloc.dart';


abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final String message;
  CartLoaded({required this.message});
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}

class GetCartLoaded extends CartState{
  final Map<String,dynamic> cartItems;

  GetCartLoaded({required this.cartItems});
}

class ItemRemoved extends CartState {
  final String message;

  ItemRemoved({required this.message});
}