part of 'cart_bloc.dart';

abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final String userId;
  final Map<String,dynamic> item;

  AddToCartEvent({required this.userId, required this.item});

 
}

class GetCartItemsEvent extends CartEvent {
  // final String userId;

  // GetCartItemsEvent({required this.userId});

}

class RemoveFromCartEvent extends CartEvent {
  final String userId;
  final String itemId;

  RemoveFromCartEvent({required this.userId, required this.itemId});
}

