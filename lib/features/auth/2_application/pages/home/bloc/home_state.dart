part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  final List<ApartModel> apartList;
  final List<ApartModel> offersList;

  const HomeInitial({required this.apartList, required this.offersList});

  @override
  List<Object> get props => [];
}

class HomeCompletedState extends HomeState {
  final List<ApartModel> apartList;
  final List<ApartModel> offersList;

  const HomeCompletedState({required this.apartList, required this.offersList});

  @override
  List<Object> get props => [apartList, offersList];
}
