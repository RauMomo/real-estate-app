import 'package:real_estate_app/app/network/provider/mongo_db_provider.dart';
import 'package:real_estate_app/features/auth/0_data/exceptions/auth_exception.dart';

abstract class HomeRemoteDatasource {
  /// requests a random advice from api
  /// returns [AdviceModel] if successfull
  /// throws a server-Exception if status code is not 200
  Future<List<Map<String, dynamic>>> getREData();
  Future<List<Map<String, dynamic>>> getOffersData();
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  HomeRemoteDatasourceImpl({required this.mainDbProvider});
  final MongoDBProvider mainDbProvider;

  @override
  Future<List<Map<String, dynamic>>> getOffersData() async {
    var res = await mainDbProvider.getOffersData().catchError((err) {
      throw ServerException();
    });

    return res;
  }

  @override
  Future<List<Map<String, dynamic>>> getREData() async {
    var res = await mainDbProvider.getREData().catchError((err) {
      throw ServerException();
    });

    return res;
  }
}
