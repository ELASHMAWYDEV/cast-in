import 'package:cast_in/ui/components/main_button.dart';
import 'package:cast_in/ui/components/post/post_card.dart';
import 'package:cast_in/ui/screens/main/main_controller.dart';
import 'package:cast_in/ui/screens/profile/profile/components/profile_and_background_photos.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Skeletonizer(
          enabled: controller.isLoading,
          ignoreContainers: true,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildProfilePhotos(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUserInfo(),
                      const SizedBox(height: 15),
                      _buildLocation(),
                      const SizedBox(height: 15),
                      _buildBio(),
                      const SizedBox(height: 30),
                      _buildPostsHeader(),
                      const SizedBox(height: 20),
                      _buildPostsList(),
                      const SizedBox(height: 20),
                      _buildEditProfileButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildProfilePhotos() {
    return ProfileAndBackgroundPhotos(editScreen: false);
  }

  Widget _buildUserInfo() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Peter Parker, 24",
                softWrap: false,
                style: AppStyle.headingTextStyle1.copyWith(fontWeight: FontWeight.bold),
              ),
              Text("Photographer"),
            ],
          ),
        ),
        _buildStatItem("834", "Followers"),
        const SizedBox(width: 20),
        _buildStatItem("162", "Following"),
      ],
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Expanded(
      child: InkWell(
          onTap: () {
            Get.find<MainController>().goToScreen(MainRouter.FOLLOWERSANDFOLLOWING);
          },
          child: Column(
            children: [
              Text(
                count,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(label),
            ],
          )),
    );
  }

  Widget _buildLocation() {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined),
        const SizedBox(width: 5),
        Text(
          "United states of america",
          style: AppStyle.bodyTextStyle3,
        ),
      ],
    );
  }

  Widget _buildBio() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hey, I'm using Cast In App!",
            style: AppStyle.bodyTextStyle3.copyWith(color: AppStyle.grey),
          ),
          const SizedBox(height: 15),
          MainButton(
            onPressed: () {
              Get.find<MainController>().goToScreen(MainRouter.UPDATE_BIO);
            },
            title: 'Update Bio',
            fullWidth: true,
            buttonType: ButtonType.outline,
          ),
        ],
      ),
    );
  }

  Widget _buildPostsHeader() {
    return Row(
      children: [
        Text(
          "Adds",
          style: AppStyle.subTitleStyle1.copyWith(fontSize: 20),
        ),
        Spacer(),
        InkWell(
          onTap: () {
            Get.find<MainController>().goToScreen(MainRouter.ADDNEWPOST);
          },
          child: Text(
            "Add Post",
            style: AppStyle.textButtonTextStyle.copyWith(fontSize: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildPostsList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.posts.length,
      separatorBuilder: (context, index) => SizedBox(height: 15),
      itemBuilder: (context, index) => PostCard(
        isOpenModalEnabled: false,
        post: controller.posts[index],
      ),
    );
  }

  Widget _buildEditProfileButton() {
    return MainButton(
      onPressed: () {
        Get.find<MainController>().goToScreen(MainRouter.EDIT_PROFILE);
      },
      title: 'Edit Profile',
      fullWidth: true,
    );
  }
}
