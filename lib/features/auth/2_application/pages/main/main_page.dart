import 'package:flutter/material.dart';
import 'package:real_estate_app/features/auth/2_application/pages/chat/chat_list.dart';
import 'package:real_estate_app/features/auth/2_application/pages/favorites/favorite_page.dart';
import 'package:real_estate_app/features/auth/2_application/pages/home/home_page.dart';
import 'package:real_estate_app/shared/constants/colors.dart';

class MainPage extends StatefulWidget {
  static const String path = '/main';
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final List<Widget> pages = [
    const HomePage(),
    const FavoritePage(),
    const ChatListPage(),
    const HomePage()
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        currentIndex: currentIndex,
        elevation: 1.0,
        selectedItemColor: ColorConstants.kPrimary,
        unselectedItemColor: ColorConstants.kGrey,
        backgroundColor: ColorConstants.kWhite,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              label: '',
              icon: const Icon(Icons.home_outlined),
              activeIcon: Column(
                children: [
                  const Icon(Icons.home_outlined),
                  Divider(
                    height: 6.0,
                    indent: 35.0,
                    endIndent: 35.0,
                    thickness: 2.0,
                    color: ColorConstants.kPrimary,
                  )
                ],
              ),
              backgroundColor: ColorConstants.kWhite),
          BottomNavigationBarItem(
              label: '',
              icon: const Icon(Icons.favorite_outlined),
              activeIcon: Column(children: [
                const Icon(Icons.favorite_outlined),
                Divider(
                  height: 6.0,
                  indent: 35.0,
                  endIndent: 35.0,
                  thickness: 2.0,
                  color: ColorConstants.kPrimary,
                )
              ]),
              backgroundColor: ColorConstants.kWhite),
          BottomNavigationBarItem(
              label: '',
              icon: const Icon(Icons.mail_outline),
              activeIcon: Column(
                children: [
                  const Icon(Icons.mail_outlined),
                  Divider(
                    height: 6.0,
                    indent: 35.0,
                    endIndent: 35.0,
                    thickness: 2.0,
                    color: ColorConstants.kPrimary,
                  )
                ],
              ),
              backgroundColor: ColorConstants.kWhite),
          BottomNavigationBarItem(
              label: '',
              icon: const Icon(Icons.person_outline),
              activeIcon: Column(
                children: [
                  const Icon(Icons.person_outline),
                  Divider(
                    height: 6.0,
                    indent: 35.0,
                    endIndent: 35.0,
                    thickness: 2.0,
                    color: ColorConstants.kPrimary,
                  )
                ],
              ),
              backgroundColor: ColorConstants.kWhite),
        ],
      ),
    );
  }
}
