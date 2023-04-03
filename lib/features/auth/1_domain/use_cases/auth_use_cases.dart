import 'package:dartz/dartz.dart';
import 'package:real_estate_app/features/auth/1_domain/entities/auth_entity.dart';
import 'package:real_estate_app/features/auth/1_domain/failures/failures.dart';
import 'package:real_estate_app/features/auth/1_domain/repositories/auth_repo.dart';

class AdviceUseCases {
  AdviceUseCases({required this.adviceRepo});
  final AuthRepo adviceRepo;

  Future<Either<Failure, AuthEntity>> checkEmail() async {
    return adviceRepo.checkEmail();
    // space for business logic
  }
}
