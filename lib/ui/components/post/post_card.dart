import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final bool isBox;

  const PostCard({
    super.key,
    required this.post,
    required this.isBox,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRouter.POST_DETAILS, arguments: post);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: isBox == true ? Border.all(color: AppStyle.grey.withValues(alpha: 0.1)) : null,
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isBox == true ? Colors.grey.withValues(alpha: 0.1) : Colors.white,
              spreadRadius: 1,
              blurRadius: 10,
              offset: isBox == true ? const Offset(0, 2) : Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostHeader(),
            const SizedBox(height: 15),
            _buildPostContent(),
            const SizedBox(height: 20),
            _buildPostActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildPostHeader() {
    return Row(
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
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 300),
                    child: Image.asset(
                      post.imageUrl![0],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 16.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: List.generate(
                //       6,
                //       (index) => Container(
                //         margin: const EdgeInsets.symmetric(horizontal: 4),
                //         width: 8,
                //         height: 8,
                //         decoration: BoxDecoration(
                //           shape: BoxShape.circle,
                //           color: index == 4 ? AppStyle.primaryColor : Colors.white.withValues(alpha: 0.8),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        );
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
          Image.asset(
            AppAssets.commentIcon,
            width: 22,
          ),
          const SizedBox(width: 6),
          Text('${post.comments}'),
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
