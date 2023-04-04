import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_estate_app/features/auth/0_data/data_sources/auth_data_sources.dart';
import 'package:real_estate_app/features/auth/0_data/exceptions/auth_exception.dart';
import 'package:real_estate_app/features/auth/1_domain/entities/auth_entity.dart';
import 'package:real_estate_app/features/auth/1_domain/failures/failures.dart';
import 'package:real_estate_app/features/auth/1_domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({required this.authRemoteDatasource});
  final AuthRemoteDatasource authRemoteDatasource;
  @override
  Future<Either<Failure, AuthEntity>> checkEmail(
      {required String email}) async {
    try {
      final result = await authRemoteDatasource.checkEmail(email: email);
      return Right(result);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    } on EmailNotFoundException catch (_) {
      return Left(EmailNotFoundFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signIn(
      {required String email, required String password}) async {
    try {
      final result =
          await authRemoteDatasource.signIn(email: email, password: password);
      return Right(result);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    } on InvalidLoginException catch (_) {
      return Left(InvalidLoginFailure());
    }
  }
}
