import 'package:cast_in/ui/screens/home/home_screen.dart';
import 'package:cast_in/ui/screens/mainLayout/main_layout_controller.dart';
import 'package:cast_in/ui/screens/messages/messages_screen.dart';
import 'package:cast_in/ui/screens/profile/profile_screen.dart';
import 'package:cast_in/ui/screens/search/search_screen.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainLayoutScreen extends StatelessWidget {
  MainLayoutScreen({super.key});

  final NavigationController navigationController = Get.put(NavigationController());

  final _children = [
    const HomeScreen(),
    const SearchScreen(),
    const MessagesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: navigationController.selectedIndex.value,
          children: _children,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: navigationController.selectedIndex.value,
            onTap: (index) => navigationController.updateIndex(index),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppStyle.primaryTextColor,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(AppAssets.homeIcon),
                activeIcon: Image.asset(AppAssets.filledHomeIcon),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(AppAssets.searchIcon),
                activeIcon: Image.asset(AppAssets.filledSearchIcon),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(AppAssets.messageIcon),
                activeIcon: Image.asset(AppAssets.filledMessageIcon),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(AppAssets.profileIcon),
                activeIcon: Image.asset(AppAssets.filledProfileIcon),
                label: '',
              ),
            ],
          ),
        ),
      );
    });
  }
}
