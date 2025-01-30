import 'package:cast_in/models/post_model.dart';
import 'package:cast_in/ui/components/post/image_controller.dart';
import 'package:cast_in/ui/components/post/share_modal.dart';
import 'package:cast_in/ui/components/post/comments_modal.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/app_style.dart';
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
  late final RxBool isLiked = RxBool(false);
  late final RxInt likesCount = RxInt(post.likes);
  late final RxInt commentsCount = RxInt(post.comments);

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
            const SizedBox(height: 10),
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
            _buildPostHeader(),
            GestureDetector(
                onTap: () => Get.toNamed(AppRouter.POST_DETAILS, arguments: post), child: _buildPostContent()),
            const SizedBox(height: 20),
            _buildPostActions(),
          ],
        );
    }
  }

  Widget _buildPostHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
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
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: AppStyle.primaryTextColor),
            color: AppStyle.primaryBgColor,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'report',
                child: Row(
                  children: [
                    Icon(Icons.flag_outlined, size: 20),
                    const SizedBox(width: 8),
                    Text('Report'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'save',
                child: Row(
                  children: [
                    Icon(Icons.bookmark_border, size: 20),
                    const SizedBox(width: 8),
                    Text('Save'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              // Handle menu item selection
              if (value == 'report') {
                // Handle report
              } else if (value == 'save') {
                // Handle save
              }
            },
          ),
        ],
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
              const SizedBox(height: 12),
              if (post.content.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    post.content,
                    style: AppStyle.bodyTextStyle2,
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
      child: Obx(() => Row(
            children: [
              GestureDetector(
                onTap: () {
                  // TODO: Implement actual like functionality with your backend
                  if (isLiked.value == true) {
                    likesCount.value = likesCount.value - 1;
                    isLiked.value = false;
                  } else {
                    likesCount.value = likesCount.value + 1;
                    isLiked.value = true;
                  }
                },
                child: Image.asset(
                  isLiked.value == true ? AppAssets.filledLikeIcon : AppAssets.likeIcon,
                  width: 22,
                ),
              ),
              const SizedBox(width: 6),
              Text('${likesCount.value}'),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    CommentsModal(post: post),
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                  );
                },
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
          )),
    );
  }
}
