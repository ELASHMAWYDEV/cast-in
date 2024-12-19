import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  final pinController = TextEditingController();
  RxBool isLoading = false.obs;
  RxString timer = '0:09'.obs;

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }

  void submitCode() {
    final code = pinController.text.trim();
    if (code.length != 4) {
      Get.snackbar(
        'Error',
        'Please enter a valid 4-digit code',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
      Get.toNamed('/profession');
    });
  }

  void resendCode() {
    timer.value = '0:09';
    Get.snackbar('Success', 'Verification code resent', snackPosition: SnackPosition.BOTTOM);
  }
}
