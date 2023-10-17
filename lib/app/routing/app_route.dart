import 'package:flutter/material.dart';
import 'package:real_estate_app/features/auth/2_application/pages/apartments/apartment_detail.dart';
import 'package:real_estate_app/features/auth/2_application/pages/apartments/book_apartment/book_apartment_page.dart';
import 'package:real_estate_app/features/auth/2_application/pages/apartments/payment_process/payment_process_page.dart';
import 'package:real_estate_app/features/auth/2_application/pages/apartments/payment_process/payment_process_success.dart';
import 'package:real_estate_app/features/auth/2_application/pages/chat/chat_list_page.dart';
import 'package:real_estate_app/features/auth/2_application/pages/chat/full_chat/full_chat_page.dart';
import 'package:real_estate_app/features/auth/2_application/pages/favorites/favorite_page.dart';
import 'package:real_estate_app/features/auth/2_application/pages/home/filter_page.dart';
import 'package:real_estate_app/features/auth/2_application/pages/main/main_page.dart';
import 'package:real_estate_app/features/auth/2_application/pages/onboarding/onboarding_page.dart';
import 'package:real_estate_app/features/auth/2_application/pages/profile/host_profile/host_profile_page.dart';
import 'package:real_estate_app/features/auth/2_application/pages/profile/profile_page.dart';
import 'package:real_estate_app/features/auth/2_application/pages/profile/review/review_page.dart';

class AppRoute {
  final String _initialRoute = '/';
  String get initialRoute => _initialRoute;

  Map<String, WidgetBuilder> _routes(BuildContext context) {
    var iRoute = initialRoute;
    // var auth = context.watch<User?>();
    return {
      iRoute: (context) => const OnboardingPage(),
      MainPage.path: (context) => const MainPage(),
      FilterPage.path: (context) => const FilterPage(),
      ApartmentDetailPage.path: (context) => const ApartmentDetailPage(),
      BookApartmentPage.path: (context) => const BookApartmentPage(),
      FavoritePage.path: (context) => const FavoritePage(),
      PaymentProcessPage.path: (context) => const PaymentProcessPage(),
      PaymentProcessSuccess.path: (context) => const PaymentProcessSuccess(),
      ChatListPage.path: (context) => const ChatListPage(),
      FullChatPage.path: (context) => const FullChatPage(),
      HostProfilePage.path: (context) => const HostProfilePage(),
      ProfilePage.path: (context) => const ProfilePage(),
      ReviewPage.path: (context) => const ReviewPage(),
    };
  }

  Map<String, WidgetBuilder> routes(context) => _routes(context);
}
