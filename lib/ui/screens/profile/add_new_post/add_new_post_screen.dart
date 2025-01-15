import 'package:cast_in/ui/components/main_button.dart';
import 'package:cast_in/ui/screens/profile/add_new_post/add_new_post_controller.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewPostScreen extends StatelessWidget {
  AddNewPostScreen({super.key});

  final AddNewPostController controller = Get.put(AddNewPostController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //spacing: 20,
        children: [
          Text(
            'Add text for advertisement.',
            style: AppStyle.headingTextStyle1.copyWith(
              fontSize: 15,
              color: AppStyle.minBlack,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppStyle.grey.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: TextField(
              maxLines: 8,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 45),
          Text(
            'Attach Images (Optional)',
            style: AppStyle.headingTextStyle1.copyWith(
              fontSize: 15,
              color: AppStyle.minBlack,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppStyle.grey.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.add_photo_alternate, size: 40),
                color: AppStyle.minBlack,
                onPressed: controller.pickImages,
              ),
            ),
          ),
          const SizedBox(height: 45),
          MainButton(
            onPressed: () {},
            title: 'Add Post',
            fullWidth: true,
          )
        ],
      ),
    );
  }
}
