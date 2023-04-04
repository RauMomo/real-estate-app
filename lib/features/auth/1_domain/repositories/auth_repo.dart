import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_estate_app/features/auth/1_domain/entities/auth_entity.dart';
import 'package:real_estate_app/features/auth/1_domain/failures/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthEntity>> checkEmail({required String email});

  Future<Either<Failure, UserCredential>> signIn(
      {required String email, required String password});
}
