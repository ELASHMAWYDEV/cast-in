import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class ProfilePhotoWidget extends StatelessWidget {
  final VoidCallback onTap;

  const ProfilePhotoWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        color: AppStyle.secondaryColor,
        strokeWidth: 2,
        dashPattern: [8, 4],
        borderType: BorderType.RRect,
        radius: const Radius.circular(16),
        child: Container(
          width: 130,
          height: 130,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppStyle.secondaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 48,
                    height: 48,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  Positioned(
                    bottom: -5,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppStyle.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Profile Photo Text
              Text("Profile Photo", style: AppStyle.bodyTextStyle2.copyWith(color: AppStyle.secondaryTextColor)),
            ],
          ),
        ),
      ),
    );
  }
}
