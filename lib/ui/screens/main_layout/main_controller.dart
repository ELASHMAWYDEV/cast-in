import 'package:cast_in/ui/screens/explore/explore_screen.dart';
import 'package:cast_in/ui/screens/home/home_screen.dart';
import 'package:cast_in/ui/screens/messages/messages_screen.dart';
import 'package:cast_in/ui/screens/profile/profile_screen.dart';
import 'package:cast_in/ui/screens/search/search_screen.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var selectedIndex = 0.obs;

  final ScrollController scrollController = ScrollController();

  final List<ScreenOptions> screensWithOptions = [
    ScreenOptions(title: "Home", screen: HomeScreen(), isBackBtnEnabled: false, trailing: [
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
    ScreenOptions(title: "Explore", screen: ExploreScreen(), isBackBtnEnabled: false),
    ScreenOptions(title: "Messages", screen: MessagesScreen(), isBackBtnEnabled: false),
    ScreenOptions(title: "Profile", screen: ProfileScreen(), isBackBtnEnabled: false),
  ];

  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}

class ScreenOptions {
  final String title;
  final Widget screen;
  final bool isBackBtnEnabled;
  final List<Widget>? trailing;

  ScreenOptions({required this.title, required this.screen, this.isBackBtnEnabled = false, this.trailing});
}
