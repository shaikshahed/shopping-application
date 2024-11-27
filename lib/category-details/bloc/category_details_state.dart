part of 'category_details_bloc.dart';

abstract class CategoryDetailsState {}

class CategoryDetailsInitialState extends CategoryDetailsState {}

class CategoryDetailsLoadingState extends CategoryDetailsState{}

class CategoryDetailsLoadedState extends CategoryDetailsState{
  final Map<String,dynamic> item;

  CategoryDetailsLoadedState({required this.item});
}

class CategoryDetailsErrorState extends CategoryDetailsState{
  final String message;

  CategoryDetailsErrorState({required this.message});
}