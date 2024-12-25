import 'package:cast_in/ui/common/custom_appbar.dart';
import 'package:cast_in/ui/components/post/post_card.dart';
import 'package:cast_in/ui/screens/post_details/post_details_controller.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostDetailsScreen extends StatelessWidget {
  PostDetailsScreen({super.key});

  final PostDetailsController controller = Get.put(PostDetailsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostDetailsController>(builder: (_) {
      final comments = [
        {'name': 'Smith', 'message': 'smith@gmail.com'},
        {'name': 'Garry', 'message': 'Awesome...'},
        {'name': 'Mille', 'message': 'Nice....'},
        {'name': 'Mille', 'message': 'Nice....'},
        {'name': 'Mille', 'message': 'Nice....'},
        {'name': 'Mille', 'message': 'Nice....'},
        {'name': 'Mille', 'message': 'Nice....'},
        {'name': 'Mille', 'message': 'Nice....'},
        {'name': 'Mille', 'message': 'Nice....'},
        {'name': 'Mille', 'message': 'Nice....'},
        {'name': 'Mille', 'message': 'Nice....'},
      ];
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Details',
          isBackBtnEnabled: true,
        ),
        body: Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 150),
                child: Column(
                  children: [
                    PostCard(post: controller.post!, isBox: false),
                    Divider(
                      color: AppStyle.grey.withValues(alpha: 0.3),
                    ),
                    ...comments.map((comment) => _buildCommentsSection(comment)),
                  ],
                ),
              ),
              _buildCommentInput(),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildCommentsSection(comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  AppAssets.testModelImage6,
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
                    comment['name'].toString(),
                    style: AppStyle.buttonTextStyle.copyWith(
                      fontSize: 14,
                      color: AppStyle.primaryTextColor,
                    ),
                  ),
                  Text(
                    comment['message'].toString(),
                    style: AppStyle.bodyTextStyle2.copyWith(
                      color: AppStyle.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Divider(
            color: AppStyle.grey.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: AppStyle.grey.withValues(alpha: 0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Message...',
                    hintStyle: AppStyle.bodyTextStyle2.copyWith(
                      color: AppStyle.grey,
                    ),
                    filled: true,
                    fillColor: AppStyle.primaryBgColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppStyle.secondaryTextColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'send',
                    style: TextStyle(color: AppStyle.primaryBgColor),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
