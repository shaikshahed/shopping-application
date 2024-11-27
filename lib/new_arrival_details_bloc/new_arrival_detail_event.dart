part of 'new_arrival_detail_bloc.dart';

abstract class NewArrivalDetailEvent {}

class FetchNewArrivalDetailEvent extends NewArrivalDetailEvent{
  final String id;

  FetchNewArrivalDetailEvent({required this.id});
  
}
