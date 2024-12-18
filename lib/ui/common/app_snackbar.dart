import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppSnackbar {
  static void showSuccess({String? title, required String message}) {
    Get.isSnackbarOpen
        ? Get.back()
        : Get.showSnackbar(GetSnackBar(
            title: title,
            message: message,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            animationDuration: Durations.medium4,
            icon: Icon(Icons.check_circle_outline, color: Colors.white),
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shouldIconPulse: true,
            boxShadows: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 2),
              )
            ],
            duration: Duration(milliseconds: 2500),
            snackStyle: SnackStyle.FLOATING,
            borderRadius: 50,
          ));
  }

  static void showError({String? title, required String message}) {
    Get.isSnackbarOpen
        ? Get.back()
        : Get.showSnackbar(GetSnackBar(
            title: title,
            message: message,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            animationDuration: Durations.medium4,
            icon: Icon(Icons.error_outline, color: Colors.white),
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shouldIconPulse: true,
            boxShadows: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 2),
              )
            ],
            duration: Duration(milliseconds: 2500),
            snackStyle: SnackStyle.FLOATING,
            borderRadius: 50,
          ));
  }

  static void showWarning({String? title, required String message}) {
    Get.isSnackbarOpen
        ? Get.back()
        : Get.showSnackbar(GetSnackBar(
            title: title,
            message: message,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.yellow.shade800,
            animationDuration: Durations.medium4,
            icon: Icon(Icons.warning_amber_outlined, color: Colors.white),
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shouldIconPulse: true,
            boxShadows: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 2),
              )
            ],
            duration: Duration(milliseconds: 2500),
            snackStyle: SnackStyle.FLOATING,
            borderRadius: 50,
          ));
  }
}
