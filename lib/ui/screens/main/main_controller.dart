import 'package:cast_in/ui/screens/explore/explore/explore_controller.dart';
import 'package:cast_in/ui/screens/explore/explore/explore_screen.dart';
import 'package:cast_in/ui/screens/explore/filter/filter_screen.dart';
import 'package:cast_in/ui/screens/explore/models_filter/models_filter_screen.dart';
import 'package:cast_in/ui/screens/home/home_controller.dart';
import 'package:cast_in/ui/screens/home/home_screen.dart';
import 'package:cast_in/ui/screens/messages/messages/messages_controller.dart';
import 'package:cast_in/ui/screens/messages/messages/messages_screen.dart';
import 'package:cast_in/ui/screens/notifications/notifications_screen.dart';
import 'package:cast_in/ui/screens/profile/edit_profile/edit_profile_screen.dart';
import 'package:cast_in/ui/screens/profile/followers_following/followers_following_screen.dart';
import 'package:cast_in/ui/screens/profile/profile/profile_controller.dart';
import 'package:cast_in/ui/screens/profile/profile/profile_screen.dart';
import 'package:cast_in/ui/screens/profile/add_new_post/add_new_post_screen.dart';
import 'package:cast_in/ui/screens/settings/settings_screen.dart';
import 'package:cast_in/utils/app_assets.dart';
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
  static const FILTER = 5;
  static const NOTIFICATIONS = 6;
  static const ADDNEWPOST = 7;
  static const EDIT_PROFILE = 8;
  static const FOLLOWERSANDFOLLOWING = 9;
  static const MODELS_FILTER = 10;
}

class MainController extends GetxController {
  var selectedIndex = 0; // For all screen
  var selectedMainIndex = 0; // 0 for home, 1 for explore, 2 for messages, 3 for profile FOR BOTTOM BAR ONLY

  final ScrollController scrollController = ScrollController();

  final List<ScreenOptions> screensWithOptions = [
    ScreenOptions(
      title: "Home",
      screenIndex: MainRouter.HOME,
      screen: HomeScreen(),
      isBackBtnEnabled: false,
      trailing: [
        IconButton(
          onPressed: () => Get.find<MainController>().goToScreen(MainRouter.NOTIFICATIONS),
          tooltip: "Notifications",
          style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppStyle.secondaryBgColor)),
          icon: Image.asset(
            AppAssets.notificationsIcon,
            width: 24,
            height: 24,
          ),
        ),
      ],
      onRefresh: () async => await Get.find<HomeController>().fetchPosts(),
    ),
    ScreenOptions(
        title: "Explore",
        screenIndex: MainRouter.EXPLORE,
        screen: ExploreScreen(),
        isBackBtnEnabled: false,
        trailing: [
          IconButton(
            onPressed: () => Get.find<MainController>().goToScreen(MainRouter.FILTER),
            tooltip: "Filter",
            icon: Image.asset(
              AppAssets.filterIcon,
              width: 24,
              height: 24,
            ),
          ),
        ],
        onRefresh: () async => await Get.find<ExploreController>().fetchPosts()),
    ScreenOptions(
        title: "Messages",
        screenIndex: MainRouter.MESSAGES,
        screen: MessagesScreen(),
        isBackBtnEnabled: false,
        onRefresh: () async => await Get.find<MessagesController>().fetchMessages()),
    ScreenOptions(
        title: "Profile",
        screenIndex: MainRouter.PROFILE,
        screen: ProfileScreen(),
        isBackBtnEnabled: false,
        onRefresh: () async => await Get.find<ProfileController>().fetchProfileData(),
        trailing: [
          IconButton(
            onPressed: () => Get.find<MainController>().goToScreen(MainRouter.SETTINGS),
            tooltip: "settings",
            icon: Image.asset(
              AppAssets.settingIcon,
              width: 24,
              height: 24,
            ),
          ),
        ]),
    ScreenOptions(
      title: "Settings",
      screenIndex: MainRouter.SETTINGS,
      isBackBtnEnabled: true,
      screen: SettingsScreen(),
    ),
    ScreenOptions(title: "Filter", screenIndex: MainRouter.FILTER, screen: FilterScreen(), isBackBtnEnabled: true),
    ScreenOptions(
        title: "Notifications",
        screenIndex: MainRouter.NOTIFICATIONS,
        screen: NotificationsScreen(),
        isBackBtnEnabled: true),
    ScreenOptions(
        title: "Add New Post", screenIndex: MainRouter.ADDNEWPOST, screen: AddNewPostScreen(), isBackBtnEnabled: true),
    ScreenOptions(
        title: "Edit Profile",
        screenIndex: MainRouter.EDIT_PROFILE,
        screen: EditProfileScreen(),
        isBackBtnEnabled: true),
    ScreenOptions(
        title: "peter packer",
        screenIndex: MainRouter.FOLLOWERSANDFOLLOWING,
        screen: FollowersFollowingScreen(),
        isBackBtnEnabled: true),
    ScreenOptions(
        title: "Models Found",
        screenIndex: MainRouter.MODELS_FILTER,
        screen: ModelsFilterScreen(),
        isBackBtnEnabled: true),
  ];

  void goToScreen(int index) {
    // Keep track of previous screen index for nested navigation
    if (index > 3) {
      // For nested screens, maintain the current main tab
      selectedMainIndex = selectedMainIndex;
    } else {
      // For main tabs, update both indices
      selectedMainIndex = index;
    }
    selectedIndex = index;

    print("selectedIndex: $selectedIndex, selectedMainIndex: $selectedMainIndex");
    update();
  }
}

class ScreenOptions {
  final String title;
  final Widget screen;
  final bool isBackBtnEnabled;
  final List<Widget>? trailing;
  final int screenIndex;
  final RefreshCallback? onRefresh;

  ScreenOptions(
      {required this.title,
      required this.screen,
      this.isBackBtnEnabled = false,
      this.trailing,
      required this.screenIndex,
      this.onRefresh});
}
