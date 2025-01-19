import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ShareModal extends StatelessWidget {
  final PostModel post;

  const ShareModal({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppStyle.primaryBgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: AppStyle.grey.withAlpha(30),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                Text(
                  'Share ${post.name}\'s post',
                  style: AppStyle.headingTextStyle2,
                ),
                const SizedBox(height: 20),
                // Search bar for users
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search users',
                      hintStyle: AppStyle.bodyTextStyle2.copyWith(color: AppStyle.grey),
                      prefixIcon: Image.asset(AppAssets.srchIcon),
                      filled: true,
                      fillColor: AppStyle.secondaryBgColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Recent users list
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10, // Replace with actual user list
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(AppAssets.testProfileImage),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'User $index',
                            style: AppStyle.bodyTextStyle2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Share to other apps button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppStyle.secondaryBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.share, color: Colors.black),
                    ),
                    title: Text(
                      'Share to...',
                      style: AppStyle.bodyTextStyle1,
                    ),
                    onTap: () {
                      Get.back();
                      Share.share(
                        'Check out this post from ${post.name}!',
                        subject: 'CastIn Post Share',
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                // Copy link button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppStyle.secondaryBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.link, color: Colors.black),
                    ),
                    title: Text(
                      'Copy link',
                      style: AppStyle.bodyTextStyle1,
                    ),
                    onTap: () async {
                      final link = 'https://castin.app/post/${post.name}'; // Replace with actual deep link
                      await Clipboard.setData(ClipboardData(text: link));
                      Get.back();
                      Get.snackbar(
                        'Success',
                        'Link copied to clipboard',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
