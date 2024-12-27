import 'package:cast_in/ui/screens/explore/explore_screen.dart';
import 'package:cast_in/ui/screens/home/home_screen.dart';
import 'package:cast_in/ui/screens/messages/messages/messages_screen.dart';
import 'package:cast_in/ui/screens/profile/profile/profile_screen.dart';
import 'package:cast_in/ui/screens/settings/settings_screen.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class MainRouter {
  // Screens Index
  static const HOME = 0;
  static const EXPLORE = 1;
  static const MESSAGES = 2;
  static const PROFILE = 3;
  static const SETTINGS = 4;
}

class MainController extends GetxController {
  var selectedIndex = 0; // For all screen
  var selectedMainIndex = 0; // 0 for home, 1 for explore, 2 for messages, 3 for profile FOR BOTTOM BAR ONLY

  final ScrollController scrollController = ScrollController();

  final List<ScreenOptions> screensWithOptions = [
    ScreenOptions(title: "Home", screenIndex: 0, screen: HomeScreen(), isBackBtnEnabled: false, trailing: [
      IconButton(
        onPressed: () => Get.toNamed(AppRouter.NOTIFICATIONS),
        tooltip: "Notifications",
        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppStyle.secondaryBgColor)),
        icon: Image.asset(
          AppAssets.notificationsIcon,
          width: 24,
          height: 24,
        ),
      ),
    ]),
    ScreenOptions(title: "Explore", screenIndex: 1, screen: ExploreScreen(), isBackBtnEnabled: false),
    ScreenOptions(title: "Messages", screenIndex: 2, screen: MessagesScreen(), isBackBtnEnabled: false),
    ScreenOptions(title: "Profile", screenIndex: 3, screen: ProfileScreen(), isBackBtnEnabled: false),
    ScreenOptions(
      title: "Settings",
      screenIndex: 4,
      screen: SettingsScreen(),
    ),
  ];

  void goToScreen(int index) {
    if (index > 3) {
      selectedMainIndex = selectedIndex;
    } else {
      selectedMainIndex = index;
    }
    selectedIndex = index;
    update();
  }
}

class ScreenOptions {
  final String title;
  final Widget screen;
  final bool isBackBtnEnabled;
  final List<Widget>? trailing;
  final int screenIndex;

  ScreenOptions(
      {required this.title,
      required this.screen,
      this.isBackBtnEnabled = false,
      this.trailing,
      required this.screenIndex});
}
