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
              controller: controller.textController,
              maxLines: 8,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
            ),
          ),
          const SizedBox(height: 45),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Attach Images (Optional)',
                style: AppStyle.headingTextStyle1.copyWith(
                  fontSize: 15,
                  color: AppStyle.minBlack,
                ),
              ),
              Obx(() => Text(
                    '${controller.selectedImages.length}/${AddNewPostController.maxImages}',
                    style: AppStyle.bodyTextStyle2.copyWith(color: AppStyle.grey),
                  )),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 265,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppStyle.grey.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Obx(() {
              if (controller.selectedImages.isEmpty) {
                return Center(
                  child: IconButton(
                    icon: const Icon(Icons.add_photo_alternate, size: 40),
                    color: AppStyle.minBlack,
                    onPressed: controller.pickImages,
                  ),
                );
              }

              return Stack(
                children: [
                  GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: controller.selectedImages.length +
                        (controller.selectedImages.length < AddNewPostController.maxImages ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == controller.selectedImages.length) {
                        return InkWell(
                          onTap: controller.pickImages,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppStyle.secondaryBgColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.add_photo_alternate, size: 30),
                          ),
                        );
                      }

                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: Stack(
                                      children: [
                                        InteractiveViewer(
                                          panEnabled: true,
                                          minScale: 0.5,
                                          maxScale: 4,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.file(
                                              controller.selectedImages[index],
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: IconButton(
                                            icon: const Icon(Icons.close, color: Colors.white),
                                            onPressed: () => Navigator.pop(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Image.file(
                                controller.selectedImages[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            left: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(50),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                padding: const EdgeInsets.all(4),
                                constraints: const BoxConstraints(),
                                icon: const Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                onPressed: () => controller.cropImage(index),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(50),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                padding: const EdgeInsets.all(4),
                                constraints: const BoxConstraints(),
                                icon: const Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                onPressed: () => controller.removeImage(index),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              );
            }),
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
