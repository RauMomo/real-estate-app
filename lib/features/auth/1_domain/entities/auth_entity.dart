import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String email;
  final String? password;

  const AuthEntity({required this.email, this.password});

  @override
  List<Object?> get props => [email, password];
}
