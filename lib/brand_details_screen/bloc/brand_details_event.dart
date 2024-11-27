part of 'brand_details_bloc.dart';

abstract class BrandDetailsEvent {}

class FetchBrandDetailsEvent extends BrandDetailsEvent{
  final String BrandName;
  final String BrandId;

  FetchBrandDetailsEvent({required this.BrandName, required this.BrandId});
}
