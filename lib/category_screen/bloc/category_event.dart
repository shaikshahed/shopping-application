part of 'category_bloc.dart';


abstract class CategoryEvent {}

class FetchCategoryEvent extends CategoryEvent{
  final String category;

  FetchCategoryEvent({required this.category});
}
