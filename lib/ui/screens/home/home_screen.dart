import 'package:cast_in/ui/components/post/post_card.dart';
import 'package:cast_in/ui/screens/main_layout/main_controller.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PostModel> posts = [
      PostModel(
        name: 'Jackie',
        username: 'Jackie',
        content:
            'Today, we are looking for the perfect model to represent our brand in an upcoming perfume advertisement.',
        avatarUrl: AppAssets.testProfileImage,
        likes: 24,
        comments: 15,
        contentType: PostContentType.text,
      ),
      PostModel(
        name: 'Jenny Wilson',
        username: 'Jenny',
        content: '',
        imageUrl: [AppAssets.testModelImage1],
        avatarUrl: AppAssets.testProfileImage,
        likes: 24,
        comments: 15,
        contentType: PostContentType.image,
      ),
      PostModel(
        name: 'Jenny Wilson',
        username: 'Jenny',
        content: '',
        imageUrl: [AppAssets.testModelImage2],
        avatarUrl: AppAssets.testProfileImage,
        likes: 24,
        comments: 15,
        contentType: PostContentType.image,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Adds',
            style: AppStyle.subTitleStyle1.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            controller: Get.find<MainController>().scrollController,
            itemCount: posts.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) => InkWell(
              child: PostCard(
                post: posts[index],
                isBox: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
