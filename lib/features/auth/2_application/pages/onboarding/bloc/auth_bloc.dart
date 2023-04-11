import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/features/auth/1_domain/failures/failures.dart';
import 'package:real_estate_app/features/auth/1_domain/use_cases/auth_use_cases.dart';
import 'package:real_estate_app/features/auth/2_application/pages/onboarding/models/user_credential_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

const generalFailureMessage = 'Ups, something gone wrong. Please try again!';
const serverFailureMessage = 'Ups, API Error. please try again!';
const cacheFailureMessage = 'Ups, cache failed. Please try again!';
const emailNotFoundFailureMessage = 'Ups, email not found';

class AuthBloc extends Bloc<AuthEvent, AuthState> with ChangeNotifier {
  final AuthUseCases useCases;
  AuthBloc(this.useCases) : super(AuthInitial(email: '')) {
    on<AuthEmailCheck>(onEmailSignIn);
    on<AuthLoginEvent>(onLoginEvent);
  }

  String emailInput = '';
  String passwordInput = '';

  Future<void> onEmailSignIn(
      AuthEmailCheck event, Emitter<AuthState> emit) async {
    debugPrint('hahe');
    emit(AuthSubmittedEmail(email: emailInput));
    final res = await useCases.checkEmail(email: event.email);
    res.fold((l) {
      debugPrint(l.toString());
      emit(AuthEmailFailed(
        message: _mapFailureToMessage(l),
      ));
    }, (r) {
      debugPrint('SUKSES');
      emit(
        AuthEmailSuccess(email: r.email),
      );
      return Right(r);
    });
  }

  Future<void> onLoginEvent(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthSubmittedPassword(password: passwordInput));

    final res =
        await useCases.signIn(email: event.email, password: event.password);
    res.fold((l) {
      debugPrint(l.toString());
      emit(AuthEmailFailed(
        message: _mapFailureToMessage(l),
      ));
    }, (r) {
      // debugPrint('SUKSES SEBAGAI USER: ${r.user!.displayName}');

      final cleanDataRes = UserCredentialModel(
          credential: r,
          displayName: r.user!.displayName ?? 'Qiko',
          email: r.user!.email!,
          isNewUser: r.additionalUserInfo!.isNewUser,
          uid: r.user!.uid);

      emit(
        AuthLoginSuccess(email: cleanDataRes.email, password: event.password),
      );
      return Right(r);
    });
  }

  listenEmailField(String email) {
    emailInput = email;
    notifyListeners();
  }

  listenPasswordField(String password) {
    passwordInput = password;
    notifyListeners();
  }

  _mapFailureToMessage(Failure l) {
    switch (l.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      case EmailNotFoundFailure:
        return emailNotFoundFailureMessage;
      default:
        return generalFailureMessage;
    }
  }
}
