import 'package:get_it/get_it.dart';
import 'package:real_estate_app/app/network/provider/db_provider.dart';
import 'package:real_estate_app/features/auth/0_data/data_sources/auth_data_sources.dart';
import 'package:real_estate_app/features/auth/0_data/repositories/auth_repo_impl.dart';
import 'package:real_estate_app/features/auth/1_domain/repositories/auth_repo.dart';
import 'package:real_estate_app/features/auth/1_domain/use_cases/auth_use_cases.dart';
import 'package:real_estate_app/features/auth/2_application/pages/onboarding/bloc/auth_bloc.dart';

final sl = GetIt.I;

Future<void> init() async {
  sl.registerLazySingleton<DBProvider>(() => DBProvider());

  await sl.get<DBProvider>().init();

  // sl.registerSingleton<AuthUseCases>(() => AuthUseCases(authRepo: sl()));

  // sl.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(
  //     auth: sl<DBProvider>().auth!, firestore: sl<DBProvider>().firestore!));

  //application layer
  sl.registerFactory<AuthBloc>(
      () => AuthBloc(
            sl(),
          ),
      instanceName: 'auth1');

  //domain layer
  sl.registerFactory<AuthUseCases>(() => AuthUseCases(authRepo: sl()));

  //data layer
  sl.registerFactory<AuthRepo>(
    () => AuthRepoImpl(authRemoteDatasource: sl()),
  );

  sl.registerFactory<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(
      auth: sl<DBProvider>().auth!, firestore: sl<DBProvider>().firestore!));
}
