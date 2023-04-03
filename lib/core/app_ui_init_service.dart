// import 'package:flutter/material.dart';
// import 'package:real_estate_app/app/network/provider/db_provider.dart';
// import 'package:real_estate_app/core/dependency_injection.dart';
// import 'package:real_estate_app/features/auth/2_application/pages/onboarding/onboarding_page.dart';

// class AppUiInitService extends StatefulWidget {
//   final Widget child;
//   const AppUiInitService({super.key, required this.child});

//   @override
//   _AppUiInitServiceState createState() {
//     return _AppUiInitServiceState();
//   }
// }

// class _AppUiInitServiceState extends State<AppUiInitService> {
//   late Widget child;
//   @override
//   void initState() {
//     child = widget.child;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return sl<DBProvider>().user != null
//         ? const Center(child: Text('masuk homepage'))
//         : const OnboardingPage();
//   }
// }
