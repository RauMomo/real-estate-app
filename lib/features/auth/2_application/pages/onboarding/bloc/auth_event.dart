part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class AuthEmailCheck extends AuthEvent {
  final String email;

  AuthEmailCheck({required this.email});

  @override
  List<Object> get props => [email];
}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
