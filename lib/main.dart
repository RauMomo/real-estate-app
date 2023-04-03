import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:real_estate_app/app/routing/app_route.dart';
import 'package:real_estate_app/app/theme/theme_service.dart';
import 'package:real_estate_app/core/dependency_injection.dart' as di;
import 'package:real_estate_app/features/auth/2_application/pages/onboarding/bloc/auth_bloc.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await di.init();

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
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider(
          create: (context) => AuthBloc(),
          lazy: true,
        )
      ],
      child: MaterialApp(
        builder: (context, child) {
          return Theme(
              data: ThemeService.buildNormalMode(context), child: child!);
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        routes: appRoute.routes,
      ),
    );
  }
}
