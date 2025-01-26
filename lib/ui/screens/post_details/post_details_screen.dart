import 'package:cast_in/ui/common/custom_appbar.dart';
import 'package:cast_in/ui/components/post/comments_modal.dart';
import 'package:cast_in/ui/components/post/post_card.dart';
import 'package:cast_in/ui/screens/post_details/post_details_controller.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostDetailsScreen extends StatelessWidget {
  PostDetailsScreen({super.key});

  final PostDetailsController controller = Get.put(PostDetailsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostDetailsController>(builder: (_) {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Details',
          isBackBtnEnabled: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: PostCard(post: controller.post!),
                      ),
                      Divider(
                        color: AppStyle.grey.withValues(alpha: 0.1),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: CommentsModal(post: controller.post!),
                      ),
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
}
