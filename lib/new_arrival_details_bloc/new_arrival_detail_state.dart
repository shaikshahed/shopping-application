part of 'new_arrival_detail_bloc.dart';


abstract class NewArrivalDetailState {}

class NewArrivalDetailInitial extends NewArrivalDetailState {}

class NewArrivalDetailLoadingState extends NewArrivalDetailState{}

class NewArrivalDetailLoadedState extends NewArrivalDetailState{
  final Map<String, dynamic> item;

  NewArrivalDetailLoadedState({required this.item});
}

class NewArrivalDetailErrorState extends NewArrivalDetailState{
  final String message;

  NewArrivalDetailErrorState({required this.message});
}
