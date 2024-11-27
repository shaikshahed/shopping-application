part of 'category_details_bloc.dart';

abstract class CategoryDetailsEvent {}

class FetchCategoryDetailsEvent extends CategoryDetailsEvent{
  final String category;
  final String categoryId;

  FetchCategoryDetailsEvent({required this.category, required this.categoryId});
}
