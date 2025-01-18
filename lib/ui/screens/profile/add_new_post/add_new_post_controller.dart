import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddNewPostController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final RxList<File> selectedImages = <File>[].obs;
  static const int maxImages = 6;

  Future<void> pickImages() async {
    if (selectedImages.length >= maxImages) {
      Get.snackbar(
        'Maximum Images',
        'You can only select up to $maxImages images',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      final remainingSlots = maxImages - selectedImages.length;
      final filesToAdd = pickedFiles.take(remainingSlots).map((file) => File(file.path)).toList();
      selectedImages.addAll(filesToAdd);

      if (pickedFiles.length > remainingSlots) {
        Get.snackbar(
          'Maximum Images',
          'Only $remainingSlots image(s) were added. Maximum limit reached.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
