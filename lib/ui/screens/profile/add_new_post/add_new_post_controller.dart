import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cast_in/utils/app_style.dart';

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

  Future<void> cropImage(int index) async {
    final file = selectedImages[index];
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Edit Image',
          toolbarColor: AppStyle.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          hideBottomControls: false,
        ),
        IOSUiSettings(
          title: 'Edit Image',
          doneButtonTitle: 'Done',
          cancelButtonTitle: 'Cancel',
          aspectRatioLockEnabled: false,
        ),
      ],
    );

    if (croppedFile != null) {
      selectedImages[index] = File(croppedFile.path);
      selectedImages.refresh();
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }
  }

  void toggleLike(int index) {
    // Implement like functionality
    Get.snackbar(
      'Liked',
      'Image marked as favorite',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
