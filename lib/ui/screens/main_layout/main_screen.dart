import 'package:cast_in/ui/common/custom_appbar.dart';
import 'package:cast_in/ui/screens/main_layout/main_controller.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainLayoutScreen extends StatelessWidget {
  MainLayoutScreen({super.key});

  final MainController navigationController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: navigationController.selectedIndex.value,
          children: navigationController.screensWithOptions
              .map((screenWithOptions) => SafeArea(
                    child: CustomScrollView(
                      controller: navigationController.scrollController,
                      slivers: <Widget>[
                        SliverAppBar(
                          expandedHeight: 60,
                          backgroundColor: Colors.transparent,
                          floating: true,
                          pinned: false,
                          automaticallyImplyLeading: false,
                          centerTitle: true,
                          flexibleSpace: CustomAppBar(
                            title: screenWithOptions.title,
                            isBackBtnEnabled: screenWithOptions.isBackBtnEnabled,
                            trailing: screenWithOptions.trailing,
                          ),
                        ),
                        SliverToBoxAdapter(child: screenWithOptions.screen),
                      ],
                    ),
                  ))
              .toList(),
        ),
        bottomNavigationBar: Container(
          height: 100,
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
