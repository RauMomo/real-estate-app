part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class HomeRequestedAparts extends HomeEvent {
  HomeRequestedAparts();

  @override
  List<Object> get props => [];
}

class HomeRequestedOffers extends HomeEvent {
  HomeRequestedOffers();

  @override
  List<Object> get props => [];
}
