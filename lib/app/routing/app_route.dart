import 'package:flutter/material.dart';
import 'package:real_estate_app/features/auth/2_application/pages/onboarding/onboarding_page.dart';

class AppRoute {
  final String _initialRoute = '/';
  String get initialRoute => _initialRoute;

  Map<String, WidgetBuilder> _routes() {
    var iRoute = initialRoute;
    return {
      iRoute: (context) => const OnboardingPage(),
    };
  }

  Map<String, WidgetBuilder> get routes => _routes();
}
