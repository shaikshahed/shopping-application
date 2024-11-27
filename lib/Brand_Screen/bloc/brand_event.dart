part of 'brand_bloc.dart';


abstract class BrandEvent{}

class FetchBrandItemsEvent extends BrandEvent{
  final String brandName;

  FetchBrandItemsEvent({required this.brandName});
}
