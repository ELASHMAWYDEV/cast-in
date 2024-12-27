import 'package:cast_in/ui/screens/explore/explore/explore_controller.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:cast_in/utils/style.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/ui/components/post/post_card.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  final ExploreController controller = Get.put(ExploreController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExploreController>(builder: (_) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  filled: true,
                  fillColor: AppStyle.secondaryBgColor,
                  hintStyle: AppStyle.bodyTextStyle2.copyWith(color: AppStyle.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                      iconSize: 24,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                ),
              ),
              const SizedBox(height: 24),
              // Models Section
              Text(
                'Models',
                style: AppStyle.headingTextStyle2,
              ),
              const SizedBox(height: 16),
              Skeletonizer(
                enabled: controller.isLoading,
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildModelImage(AppAssets.testModelImage1),
                    _buildModelImage(AppAssets.testModelImage2),
                    _buildModelImage(AppAssets.testModelImage3),
                    _buildModelImage(AppAssets.testModelImage4),
                    _buildModelImage(AppAssets.testModelImage5),
                    _buildModelImage(AppAssets.testModelImage6),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Adds Section
              Text(
                'Adds',
                style: AppStyle.headingTextStyle2,
              ),
              const SizedBox(height: 16),
              Skeletonizer(
                enabled: controller.isLoading,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) => Column(
                    children: [
                      PostCard(
                        post: PostModel(
                          name: 'Jackie',
                          username: 'Jackie',
                          content:
                              'Today, we are looking for the perfect model to represent our brand in an upcoming perfume advertisement.',
                          likes: 24,
                          comments: 15,
                          avatarUrl: AppAssets.testProfileImage,
                          contentType: PostContentType.text,
                        ),
                        isBox: true,
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildModelImage(String imageAsset) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        imageAsset,
        fit: BoxFit.cover,
      ),
    );
  }
}
