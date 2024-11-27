part of 'brand_details_bloc.dart';

abstract class BrandDetailsState {}

class BrandDetailsInitialState extends BrandDetailsState {}

class BrandDetailsLoadingState extends BrandDetailsState{}

class BrandDetailsLoadedState extends BrandDetailsState{
  final Map<String,dynamic> item;

  BrandDetailsLoadedState({required this.item});
}

class BrandDetailsErrorState extends BrandDetailsState{
  final String message;

  BrandDetailsErrorState({required this.message});
}