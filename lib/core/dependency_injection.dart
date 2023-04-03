import 'package:get_it/get_it.dart';
import 'package:real_estate_app/app/network/provider/db_provider.dart';

final sl = GetIt.I;

Future<void> init() async {
  sl.registerFactory<DBProvider>(() => DBProvider());

  await sl.get<DBProvider>().init();
}
