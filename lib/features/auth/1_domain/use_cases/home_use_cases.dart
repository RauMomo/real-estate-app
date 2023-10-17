import 'package:dartz/dartz.dart';
import 'package:real_estate_app/features/auth/1_domain/failures/failures.dart';
import 'package:real_estate_app/features/auth/1_domain/repositories/home_repo.dart';
import 'package:real_estate_app/features/auth/2_application/pages/home/models/apart_model.dart';

class HomeUseCases {
  HomeUseCases({required this.homeRepo});
  final HomeRepo homeRepo;

  Future<Either<Failure, List<ApartModel>>> getREData() async {
    final res = await homeRepo.getREData();
    return res.fold((l) => Left(l), (r) {
      final reRes = r.map((e) => ApartModel.fromMap(e)).toList();
      return Right(reRes);
    });
  }

  Future<Either<Failure, List<ApartModel>>> getOffersData() async {
    final res = await homeRepo.getOffersData();
    return res.fold((l) => Left(l), (r) {
      final offersRes = r.map((e) => ApartModel.fromMap(e)).toList();
      return Right(offersRes);
    });
  }
}
