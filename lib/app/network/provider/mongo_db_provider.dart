import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:real_estate_app/shared/constants/database.dart';

class MongoDBProvider {
  static Db? db;
  static DbCollection? realEstateCollection;
  static DbCollection? offersCollection;
  connect() async {
    Db db = await Db.create(MONGO_CONN_URL);
    if (!db.isConnected) {
      await db.open();
      inspect(db);
      realEstateCollection = db.collection(RE_COLLECTION);
      offersCollection = db.collection(OFFERS_COLLECTION);
    }
  }

  Future<List<Map<String, dynamic>>> getREData() async {
    final arrData = await realEstateCollection!.find().toList();
    return arrData;
  }

  Future<List<Map<String, dynamic>>> getOffersData() async {
    final arrData = offersCollection!
        .find()
        .where((event) => event.containsKey('offerDetail'))
        .toList();
    return arrData;
  }
}
