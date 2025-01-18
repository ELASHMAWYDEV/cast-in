import 'package:cast_in/ui/components/post/image_controller.dart';
import 'package:cast_in/ui/components/post/share_modal.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final bool isOpenModalEnabled;

  PostCard({
    super.key,
    required this.post,
    this.isOpenModalEnabled = true,
  });

  final ImageController imageController = Get.put(ImageController());
  final PhotoViewScaleStateController _scaleStateController = PhotoViewScaleStateController();

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            PhotoView(
              imageProvider: AssetImage(imageUrl),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
              backgroundDecoration: const BoxDecoration(color: Colors.transparent),
              scaleStateController: PhotoViewScaleStateController(),
              scaleStateChangedCallback: (state) {
                if (state == PhotoViewScaleState.zoomedOut || state == PhotoViewScaleState.initial) {
                  Navigator.of(context).pop();
                }
              },
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (post.contentType) {
      case PostContentType.text:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostHeader(),
            const SizedBox(height: 20),
            GestureDetector(
                onTap: () => Get.toNamed(AppRouter.POST_DETAILS, arguments: post), child: _buildPostContent()),
            const SizedBox(height: 20),
            _buildPostActions(),
          ],
        );
      case PostContentType.image:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                GestureDetector(
                    onTap: () => Get.toNamed(AppRouter.POST_DETAILS, arguments: post), child: _buildPostContent()),
                _buildPostHeader(),
              ],
            ),
            const SizedBox(height: 20),
            _buildPostActions(),
          ],
        );
    }
  }

  Widget _buildPostHeader() {
    final Color nameColor =
        post.contentType == PostContentType.text ? AppStyle.primaryTextColor : AppStyle.primaryBgColor;
    final Color usernameColor = post.contentType == PostContentType.text ? AppStyle.grey : AppStyle.primaryBgColor;

    return Hero(
      tag: 'profile_image_${post.id}',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRouter.VIEW_PROFILE, arguments: post);
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(post.contentType == PostContentType.text ? 8 : 50),
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
                        style: AppStyle.buttonTextStyle.copyWith(color: nameColor).copyWith(
                            shadows: post.contentType == PostContentType.image
                                ? [
                                    Shadow(
                                      color: Colors.black.withAlpha(50),
                                      offset: const Offset(1, 1),
                                      blurRadius: 2,
                                    ),
                                  ]
                                : null),
                      ),
                      Text(
                        '@${post.username}',
                        style: AppStyle.bodyTextStyle2.copyWith(color: usernameColor).copyWith(
                            shadows: post.contentType == PostContentType.image
                                ? [
                                    Shadow(
                                      color: Colors.black.withAlpha(50),
                                      offset: const Offset(1, 1),
                                      blurRadius: 2,
                                    ),
                                  ]
                                : null),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert,
                  color:
                      post.contentType == PostContentType.text ? AppStyle.primaryTextColor : AppStyle.primaryBgColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostContent() {
    switch (post.contentType) {
      case PostContentType.text:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            post.content,
            style: AppStyle.bodyTextStyle2.copyWith(color: AppStyle.grey),
          ),
        );
      case PostContentType.image:
        imageController.loadImageAndCalculateRatio(post.imageUrl![0]);
        return Obx(() {
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
              Skeletonizer(
                enabled: imageController.matchingRatio.value == null ||
                    (imageController.matchingRatio.value?.width == 0 ||
                        imageController.matchingRatio.value?.height == 0),
                child: imageController.matchingRatio.value == null
                    ? const SizedBox()
                    : AspectRatio(
                        aspectRatio:
                            imageController.matchingRatio.value!.width / imageController.matchingRatio.value!.height,
                        child: GestureDetector(
                          onTap: () => _showImageDialog(Get.context!, post.imageUrl![0]),
                          child: ClipRRect(
                            child: PhotoView.customChild(
                              backgroundDecoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              heroAttributes: PhotoViewHeroAttributes(
                                tag: 'post_image_${post.imageUrl![0]}',
                              ),
                              enableRotation: false,
                              tightMode: true,
                              scaleStateController: _scaleStateController,
                              minScale: PhotoViewComputedScale.contained,
                              maxScale: PhotoViewComputedScale.covered,
                              scaleStateChangedCallback: (state) {
                                if (state != PhotoViewScaleState.covering &&
                                    state != PhotoViewScaleState.originalSize) {
                                  _scaleStateController.scaleState = PhotoViewScaleState.originalSize;
                                }
                              },
                              disableGestures: isOpenModalEnabled,
                              child: Image.asset(
                                post.imageUrl![0],
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          );
        });
    }
  }

  Widget _buildPostActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              Get.bottomSheet(
                ShareModal(post: post),
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
              );
            },
            child: Image.asset(
              AppAssets.shareIcon,
              width: 22,
            ),
          ),
        ],
      ),
    );
  }
}
