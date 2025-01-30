import 'package:cast_in/ui/screens/profile/followers_following/followers_following_controller.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowUserItem extends StatelessWidget {
  final bool isFollowing;

  const FollowUserItem({
    super.key,
    required this.isFollowing,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FollowersFollowingController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey[300],
              backgroundImage: AssetImage(
                AppAssets.testProfileImage,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "name",
                    style: AppStyle.buttonTextStyle.copyWith(color: AppStyle.primaryTextColor),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'belle_benson',
                    style: AppStyle.bodyTextStyle3.copyWith(color: AppStyle.grey),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isFollowing ? AppStyle.grey2 : AppStyle.secondaryTextColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                isFollowing ? 'Following' : 'Follow',
                style: AppStyle.buttonTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
