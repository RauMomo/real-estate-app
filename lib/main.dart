import 'package:firebase_auth/firebase_auth.dart' as au;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/app/network/observer/bloc_observer.dart';
import 'package:real_estate_app/app/network/provider/db_provider.dart';
import 'package:real_estate_app/app/network/provider/stream_chat_provider.dart';
import 'package:real_estate_app/app/routing/app_route.dart';
import 'package:real_estate_app/app/theme/theme_service.dart';
import 'package:real_estate_app/core/dependency_injection.dart' as di;
import 'package:real_estate_app/core/dependency_injection.dart';
import 'package:real_estate_app/features/auth/2_application/pages/chat/bloc/chat_bloc.dart';
import 'package:real_estate_app/features/auth/2_application/pages/home/bloc/home_bloc.dart';
import 'package:real_estate_app/features/auth/2_application/pages/main/main_page.dart';
import 'package:real_estate_app/features/auth/2_application/pages/onboarding/bloc/auth_bloc.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await di.init();
  Bloc.observer = MyBlocObserver();

  FlutterNativeSplash.remove();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRoute = AppRoute();
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final auth = sl<DBProvider>().auth;
    return MultiBlocProvider(
      providers: [
        StreamProvider<au.User?>(
            create: (context) => auth?.authStateChanges(), initialData: null),
        BlocProvider<AuthBloc>(
          create: (_) => di.sl<AuthBloc>(instanceName: 'auth1'),
        ),
        BlocProvider<HomeBloc>(
          create: (_) => di.sl<HomeBloc>(instanceName: 'home1'),
        ),
        BlocProvider<ChatBloc>(
          create: (_) => di.sl<ChatBloc>(instanceName: 'chat1'),
        ),
      ],
      child: MaterialApp(
        builder: EasyLoading.init(
          builder: (context, child) {
            EasyLoading.init();
            return Theme(
              data: ThemeService.buildNormalMode(context),
              child: StreamChatCore(
                  client: di.sl<StreamChatProvider>().client, child: child!),
            );
          },
        ),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: auth != null ? MainPage.path : '/',
        routes: appRoute.routes(context),
      ),
    );
  }
}
