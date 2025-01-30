import 'package:cast_in/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppDialog {
  static void showDialog({required Widget content}) {
    Get.dialog(Dialog(
      backgroundColor: AppStyle.primaryBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () => Get.back(closeOverlays: true),
                      icon: Icon(
                        Icons.close_rounded,
                        color: AppStyle.primaryTextColor,
                      ))
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
                  child: content,
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
