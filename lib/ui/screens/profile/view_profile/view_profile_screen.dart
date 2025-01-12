import 'package:cast_in/ui/common/custom_appbar.dart';
import 'package:cast_in/ui/components/main_button.dart';

import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'view_profile_controller.dart';

class ViewProfileScreen extends StatelessWidget {
  ViewProfileScreen({super.key});

  final ViewProfileController controller = Get.put(ViewProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewProfileController>(
      builder: (_) => Scaffold(
        appBar: CustomAppBar(
          title: "View Profile",
          isBackBtnEnabled: true,
        ),
        body: Skeletonizer(
          enabled: controller.isLoading,
          ignoreContainers: true,
          child: RefreshIndicator(
            onRefresh: () async => await controller.fetchProfile(),
            color: AppStyle.secondaryColor,
            displacement: 50,
            backgroundColor: AppStyle.primaryBgColor,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  _buildStats(),
                  _buildLocation(),
                  _buildActionButtons(),
                  _buildBio(),
                  _buildPhotosSection(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.testModelImage1),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: -40,
          left: 20,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 4),
              borderRadius: BorderRadius.circular(100),
            ),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(AppAssets.testProfileImage),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${controller.name}, ${controller.age}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Height-${controller.height}"),
              ],
            ),
          ),
          _buildStatItem("Followers", controller.followers.toString()),
          const SizedBox(width: 20),
          _buildStatItem("Following", controller.following.toString()),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label),
      ],
    );
  }

  Widget _buildLocation() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined),
          const SizedBox(width: 5),
          Text(controller.location),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: MainButton(
              onPressed: () {},
              title: "Follow",
              buttonType: ButtonType.primary,
              fullWidth: true,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: MainButton(
              onPressed: () {},
              title: "Message",
              buttonType: ButtonType.outline,
              fullWidth: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBio() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        controller.bio,
        style: const TextStyle(
          fontSize: 14,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildPhotosSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Photos",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: controller.photos.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                  //onTap: () => Get.toNamed(AppRouter.POST_DETAILS, arguments:post ),
                  child: Image.asset(
                    controller.photos[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
