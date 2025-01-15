import 'package:cast_in/ui/components/post/image_controller.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  PostCard({
    super.key,
    required this.post,
  });

  final ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPostHeader(),
        const SizedBox(height: 15),
        GestureDetector(onTap: () => Get.toNamed(AppRouter.POST_DETAILS, arguments: post), child: _buildPostContent()),
        const SizedBox(height: 20),
        _buildPostActions(),
      ],
    );
  }

  Widget _buildPostHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRouter.VIEW_PROFILE);
          },
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  post.avatarUrl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.name,
                    style: AppStyle.buttonTextStyle.copyWith(color: AppStyle.primaryTextColor),
                  ),
                  Text(
                    '@${post.username}',
                    style: AppStyle.bodyTextStyle2.copyWith(color: AppStyle.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        Icon(Icons.more_vert, color: AppStyle.more),
      ],
    );
  }

  Widget _buildPostContent() {
    switch (post.contentType) {
      case PostContentType.text:
        return Text(
          post.content,
          style: AppStyle.bodyTextStyle2.copyWith(color: AppStyle.grey),
        );
      case PostContentType.image:
        imageController.loadImageAndCalculateRatio(post.imageUrl![0]);
        return Obx(() {
          if (imageController.matchingRatio.value == null) {
            return Center(
                child: CircularProgressIndicator(
              color: AppStyle.primaryColor,
            ));
          }
          final matchingRatio = imageController.matchingRatio.value!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (post.content.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    post.content,
                    style: AppStyle.bodyTextStyle2.copyWith(color: AppStyle.grey),
                  ),
                ),
              const SizedBox(height: 8),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: AspectRatio(
                      aspectRatio: matchingRatio.width / matchingRatio.height,
                      child: Image.asset(
                        post.imageUrl![0],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
    }
  }

  Widget _buildPostActions() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Image.asset(
            AppAssets.filledLikeIcon,
            width: 22,
          ),
          const SizedBox(width: 6),
          Text('${post.likes}'),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () => Get.toNamed(AppRouter.POST_DETAILS, arguments: post),
            child: Row(
              children: [
                Image.asset(
                  AppAssets.commentIcon,
                  width: 22,
                ),
                const SizedBox(width: 6),
                Text('${post.comments}'),
              ],
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Image.asset(
            AppAssets.shareIcon,
            width: 22,
          ),
        ],
      ),
    );
  }
}
