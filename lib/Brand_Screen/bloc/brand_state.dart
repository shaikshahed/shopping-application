// part of 'brand_bloc.dart';

// abstract class BrandState {}

// class BrandInitialState extends BrandState {}

// class BrandLoadingState extends BrandState{}

// class BrandLoadedState extends BrandState{
//   final List<dynamic> item;

//   BrandLoadedState({required this.item});
// }

// class BrandErrorState extends BrandState{
//   final String message;

//   BrandErrorState({required this.message});
// }
part of 'brand_bloc.dart';

abstract class BrandState {}

class BrandInitialState extends BrandState {}

class BrandLoadingState extends BrandState {}

class BrandLoadedState extends BrandState {
  final List<dynamic> clothingItems;
  final List<dynamic> footwearItems;

  BrandLoadedState({required this.clothingItems, required this.footwearItems});
}

class BrandErrorState extends BrandState {
  final String message;

  BrandErrorState({required this.message});
}
