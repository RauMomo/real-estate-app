import 'package:dartz/dartz.dart';
import 'package:real_estate_app/features/auth/1_domain/failures/failures.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<Map<String, dynamic>>>> getREData();
  Future<Either<Failure, List<Map<String, dynamic>>>> getOffersData();
}
