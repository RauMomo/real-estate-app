import 'package:flutter/material.dart';
import 'package:real_estate_app/features/auth/2_application/pages/apartments/apartment_detail.dart';
import 'package:real_estate_app/features/auth/2_application/pages/apartments/book_apartment/book_apartment_page.dart';
import 'package:real_estate_app/features/auth/2_application/pages/apartments/payment_process/payment_process_page.dart';
import 'package:real_estate_app/features/auth/2_application/pages/apartments/payment_process/payment_process_success.dart';
import 'package:real_estate_app/features/auth/2_application/pages/chat/chat_list.dart';
import 'package:real_estate_app/features/auth/2_application/pages/favorites/favorite_page.dart';
import 'package:real_estate_app/features/auth/2_application/pages/home/filter_page.dart';
import 'package:real_estate_app/features/auth/2_application/pages/main/main_page.dart';
import 'package:real_estate_app/features/auth/2_application/pages/onboarding/onboarding_page.dart';

class AppRoute {
  final String _initialRoute = '/';
  String get initialRoute => _initialRoute;

  Map<String, WidgetBuilder> _routes(bool isLogin) {
    var iRoute = initialRoute;
    return {
      iRoute: (context) => isLogin ? const MainPage() : const OnboardingPage(),
      MainPage.path: (context) => const MainPage(),
      FilterPage.path: (context) => const FilterPage(),
      ApartmentDetailPage.path: (context) => const ApartmentDetailPage(),
      BookApartmentPage.path: (context) => const BookApartmentPage(),
      FavoritePage.path: (context) => const FavoritePage(),
      PaymentProcessPage.path: (context) => const PaymentProcessPage(),
      PaymentProcessSuccess.path: (context) => const PaymentProcessSuccess(),
      ChatListPage.path: (context) => const ChatListPage(),
    };
  }

  Map<String, WidgetBuilder> routes(bool isLogin) => _routes(isLogin);
}
