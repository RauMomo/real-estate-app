import 'package:get_it/get_it.dart';
import 'package:real_estate_app/app/network/provider/db_provider.dart';
import 'package:real_estate_app/app/network/provider/mongo_db_provider.dart';
import 'package:real_estate_app/app/network/provider/stream_chat_provider.dart';
import 'package:real_estate_app/features/auth/0_data/data_sources/auth_data_sources.dart';
import 'package:real_estate_app/features/auth/0_data/data_sources/home_data_sources.dart';
import 'package:real_estate_app/features/auth/0_data/repositories/auth_repo_impl.dart';
import 'package:real_estate_app/features/auth/0_data/repositories/home_repo_impl.dart';
import 'package:real_estate_app/features/auth/1_domain/repositories/auth_repo.dart';
import 'package:real_estate_app/features/auth/1_domain/repositories/home_repo.dart';
import 'package:real_estate_app/features/auth/1_domain/use_cases/auth_use_cases.dart';
import 'package:real_estate_app/features/auth/1_domain/use_cases/home_use_cases.dart';
import 'package:real_estate_app/features/auth/2_application/pages/chat/bloc/chat_bloc.dart';
import 'package:real_estate_app/features/auth/2_application/pages/home/bloc/home_bloc.dart';
import 'package:real_estate_app/features/auth/2_application/pages/onboarding/bloc/auth_bloc.dart';
import 'package:real_estate_app/shared/constants/chatting.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

final sl = GetIt.I;

Future<void> init() async {
  sl.registerLazySingleton<DBProvider>(() => DBProvider());

  await sl.get<DBProvider>().init();

  sl.registerLazySingleton<MongoDBProvider>(() => MongoDBProvider());

  await sl.get<MongoDBProvider>().connect();

  sl.registerLazySingleton<StreamChatProvider>(
    () => StreamChatProvider(
      client: StreamChatClient(ChattingConst.API_KEY, logLevel: Level.INFO),
    ),
  );

  await sl.get<StreamChatProvider>().init();

  //application layer
  sl.registerFactory<AuthBloc>(
      () => AuthBloc(
            sl(),
          ),
      instanceName: 'auth1');

  sl.registerFactory<HomeBloc>(() => HomeBloc(sl()), instanceName: 'home1');

  sl.registerFactory<ChatBloc>(() => ChatBloc(), instanceName: 'chat1');

  //domain layer
  sl.registerFactory<AuthUseCases>(() => AuthUseCases(authRepo: sl()));

  sl.registerFactory<HomeUseCases>(() => HomeUseCases(homeRepo: sl()));

  //data layer
  sl.registerFactory<AuthRepo>(
    () => AuthRepoImpl(authRemoteDatasource: sl()),
  );

  sl.registerFactory<HomeRepo>(
    () => HomeRepoImpl(datasource: sl()),
  );

  sl.registerFactory<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(
      auth: sl<DBProvider>().auth!, firestore: sl<DBProvider>().firestore!));

  sl.registerFactory<HomeRemoteDatasource>(
    () => HomeRemoteDatasourceImpl(
      mainDbProvider: sl<MongoDBProvider>(),
    ),
  );
}
