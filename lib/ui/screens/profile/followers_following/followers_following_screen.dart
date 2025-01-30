import 'package:cast_in/ui/screens/profile/followers_following/component/follow_user_item.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'followers_following_controller.dart';

class FollowersFollowingScreen extends StatelessWidget {
  FollowersFollowingScreen({super.key});

  final FollowersFollowingController controller = Get.put(FollowersFollowingController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(children: [
        TabBar(
          tabs: const [
            Tab(text: "Followers"),
            Tab(text: "Following"),
          ],
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: AppStyle.lightGrey,
          labelColor: AppStyle.secondaryTextColor,
          unselectedLabelColor: AppStyle.primaryTextColor,
          indicatorColor: AppStyle.secondaryTextColor,
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: AppStyle.bodyTextStyle2.copyWith(color: AppStyle.grey),
              suffixIcon: Image.asset(AppAssets.srchIcon),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Obx(() {
          if (controller.following.isEmpty || controller.followers.isEmpty) {
            return Center(child: Text("No followers or following data."));
          }
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              children: [
                ListView.separated(
                  itemCount: controller.followers.length,
                  itemBuilder: (context, index) => FollowUserItem(
                    isFollowing: false,
                  ),
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: AppStyle.grey.withValues(alpha: .2),
                    );
                  },
                ),
                ListView.separated(
                  itemCount: controller.following.length,
                  itemBuilder: (context, index) => FollowUserItem(
                    isFollowing: true,
                  ),
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: AppStyle.grey.withValues(alpha: .2),
                    );
                  },
                ),
              ],
            ),
          );
        })
      ]),
    );
  }
}
