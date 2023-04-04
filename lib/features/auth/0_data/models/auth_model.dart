import 'package:equatable/equatable.dart';
import 'package:real_estate_app/features/auth/1_domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity with EquatableMixin {
  AuthModel({required String email, String? password})
      : super(email: email, password: password);

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(email: json['email']);
  }

  Map<String, dynamic> toJson() => {'email': email};
}
