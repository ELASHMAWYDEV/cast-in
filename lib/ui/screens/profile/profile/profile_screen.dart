import 'package:cast_in/ui/components/main_button.dart';
import 'package:cast_in/ui/components/post/post_card.dart';
import 'package:cast_in/ui/screens/main/main_controller.dart';
import 'package:cast_in/ui/screens/profile/profile/components/profile_and_background_photos.dart';
import 'package:cast_in/utils/app_style.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:cast_in/models/user_model.dart';

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
    return ProfileAndBackgroundPhotos(
      editScreen: false,
      profileImageUrl: controller.userProfile?.profileImageUrl,
      coverImageUrl: controller.userProfile?.coverImageUrl,
    );
  }

  Widget _buildUserInfo() {
    final UserModel? user = controller.userProfile;
    final String displayName =
        user != null ? "${user.fullName}${user.age != null ? ', ${user.age}' : ''}" : "Loading...";
    final String profession = user?.profession ?? "No profession set";
    final bool isModel = user?.userType == UserType.model;

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayName,
                softWrap: false,
                style: AppStyle.headingTextStyle1.copyWith(fontWeight: FontWeight.bold),
              ),
              if (isModel) Text(profession),
            ],
          ),
        ),
        _buildStatItem(controller.followersCount.toString(), "Followers"),
        const SizedBox(width: 20),
        _buildStatItem(controller.followingCount.toString(), "Following"),
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
    final UserModel? user = controller.userProfile;
    final String location = user != null ? "${user.city}, ${user.country}" : "Location not set";

    return Row(
      children: [
        const Icon(Icons.location_on_outlined),
        const SizedBox(width: 5),
        Text(
          location,
          style: AppStyle.bodyTextStyle3,
        ),
      ],
    );
  }

  Widget _buildBio() {
    final UserModel? user = controller.userProfile;
    final String bio = user?.bio ?? "Hey, I'm using Cast In App!";
    final bool isModel = user?.userType == UserType.model;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bio,
            style: AppStyle.bodyTextStyle3.copyWith(color: AppStyle.grey),
          ),
          const SizedBox(height: 15),
          if (isModel)
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
    final bool isModel = controller.userProfile?.userType == UserType.model;
    return Row(
      children: [
        Text(
          isModel ? "Portfolio" : "Adds",
          style: AppStyle.subTitleStyle1.copyWith(fontSize: 20),
        ),
        Spacer(),
        InkWell(
          onTap: () {
            Get.find<MainController>().goToScreen(MainRouter.ADDNEWPOST);
          },
          child: Text(
            isModel ? "Add to Portfolio" : "Add Post",
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
      separatorBuilder: (context, index) => SizedBox(height: 30),
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
