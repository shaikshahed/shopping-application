part of 'new_arrival_bloc.dart';

abstract class NewArrivalState {}

class NewArrivalInitialState extends NewArrivalState {}

class NewArrivalLoadingState extends NewArrivalState{}

class NewArrivalLoadedState extends NewArrivalState{
  final List<Map<String, dynamic>> items;

  NewArrivalLoadedState({required this.items});
}

class NewArrivalErrorState extends NewArrivalState{
  final String message;

  NewArrivalErrorState({required this.message});
}