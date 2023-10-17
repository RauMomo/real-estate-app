import 'package:dartz/dartz.dart';
import 'package:real_estate_app/features/auth/0_data/data_sources/home_data_sources.dart';
import 'package:real_estate_app/features/auth/0_data/exceptions/auth_exception.dart';
import 'package:real_estate_app/features/auth/1_domain/failures/failures.dart';
import 'package:real_estate_app/features/auth/1_domain/repositories/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDatasource datasource;

  HomeRepoImpl({required this.datasource});

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getOffersData() async {
    try {
      final result = await datasource.getOffersData();
      return Right(result);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getREData() async {
    try {
      final result = await datasource.getREData();
      return Right(result);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }
}
