import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_estate_app/features/auth/1_domain/entities/auth_entity.dart';
import 'package:real_estate_app/features/auth/1_domain/failures/failures.dart';
import 'package:real_estate_app/features/auth/1_domain/repositories/auth_repo.dart';

class AuthUseCases {
  AuthUseCases({required this.authRepo});
  final AuthRepo authRepo;

  Future<Either<Failure, AuthEntity>> checkEmail(
      {required String email}) async {
    return authRepo.checkEmail(email: email);
  }

  Future<Either<Failure, UserCredential>> signIn(
      {required String email, required String password}) async {
    return authRepo.signIn(email: email, password: password);
  }
}
