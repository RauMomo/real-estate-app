// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  String email;

  AuthInitial({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class AuthSubmittedEmail extends AuthState {
  String email;

  AuthSubmittedEmail({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class AuthSubmittedPassword extends AuthState {
  String password;

  AuthSubmittedPassword({
    required this.password,
  });

  @override
  List<Object> get props => [password];
}

class AuthEmailFailed extends AuthState {
  final String message;

  AuthEmailFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthEmailSuccess extends AuthState {
  final String email;

  AuthEmailSuccess({required this.email});

  @override
  List<Object> get props => [email];
}

class AuthLoginSuccess extends AuthState {
  final String email;
  final String password;

  AuthLoginSuccess({required this.email, required this.password});

  @override
  List<Object> get props => [email];
}
