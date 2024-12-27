import 'package:cast_in/ui/screens/main/main_controller.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        controller: Get.find<MainController>().scrollController,
        children: [
          NotificationItem(
            profileImage: AppAssets.testProfileImage,
            username: 'James',
            action: 'like your advertisement.',
            timeAgo: 'an hour ago',
          ),
          Divider(
            height: 1,
            color: AppStyle.secondaryBgColor,
            indent: 20,
            endIndent: 20,
          ),
          NotificationItem(
            profileImage: AppAssets.testProfileImage,
            username: 'Jenny Wilson',
            action: 'commented on your advertisement.',
            timeAgo: 'an hour ago',
          ),
        ],
      ),
    );
  }
}
