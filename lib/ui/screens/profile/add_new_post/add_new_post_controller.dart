import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddNewPostController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final RxList<File> selectedImages = <File>[].obs;

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
    }
  }
}
