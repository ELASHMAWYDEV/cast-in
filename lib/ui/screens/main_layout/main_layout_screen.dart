import 'package:cast_in/ui/screens/home/home_screen.dart';
import 'package:cast_in/ui/screens/main_layout/main_layout_controller.dart';
import 'package:cast_in/ui/screens/messages/messages_screen.dart';
import 'package:cast_in/ui/screens/profile/profile_screen.dart';
import 'package:cast_in/ui/screens/search/search_screen.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainLayoutScreen extends StatelessWidget {
  MainLayoutScreen({super.key});

  final MainLayoutController navigationController = Get.put(MainLayoutController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: navigationController.selectedIndex.value,
          children: navigationController.screens,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            elevation: 4,
            backgroundColor: AppStyle.primaryBgColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: navigationController.selectedIndex.value,
            onTap: (index) => navigationController.updateIndex(index),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppStyle.primaryTextColor,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(AppAssets.homeIcon, width: 24),
                activeIcon: Image.asset(AppAssets.filledHomeIcon, width: 24),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(AppAssets.searchIcon, width: 24),
                activeIcon: Image.asset(AppAssets.filledSearchIcon, width: 24),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.messageIcon,
                  width: 24,
                ),
                activeIcon: Image.asset(AppAssets.filledMessageIcon, width: 24),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(AppAssets.profileIcon, width: 24),
                activeIcon: Image.asset(AppAssets.filledProfileIcon, width: 24),
                label: '',
              ),
            ],
          ),
        ),
      );
    });
  }
}
