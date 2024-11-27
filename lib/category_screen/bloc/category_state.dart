part of 'category_bloc.dart';

abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState{}

class CategoryLoadedState extends CategoryState{
  final List<dynamic> categoryData;

  CategoryLoadedState({required this.categoryData});
}

class CategoryErrorState extends CategoryState{
  final String message;

  CategoryErrorState({required this.message});
}
