import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/features/auth/1_domain/use_cases/home_use_cases.dart';
import 'package:real_estate_app/features/auth/2_application/pages/home/models/apart_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> with ChangeNotifier {
  final HomeUseCases useCases;

  HomeBloc(this.useCases)
      : super(HomeInitial(apartList: List.empty(), offersList: List.empty())) {
    on<HomeRequestedAparts>(onRequestedAparts);
  }

  List<ApartModel> apartList = [];
  List<ApartModel> offersList = [];

  Future<void> onRequestedAparts(
      HomeRequestedAparts event, Emitter<HomeState> emit) async {
    if (state is HomeInitial) {
      final reRes = await useCases.getREData();
      reRes.fold((l) {
        debugPrint('Perkiraan error:${l.toString()}');
      }, (r) {
        apartList = r;
      });

      final offersRes = await useCases.getOffersData();

      offersRes.fold((l) {
        debugPrint('Perkiraan error:${l.toString()}');
      }, (r) {
        offersList = r;
      });
      emit(HomeCompletedState(apartList: apartList, offersList: offersList));
    }
  }
}
