import 'package:cast_in/utils/app_assets.dart';
import 'package:flutter/material.dart';

class ProfileAndBackgroundPhotos extends StatelessWidget {
  const ProfileAndBackgroundPhotos({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Image.asset(
        AppAssets.backgroundImage,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      Positioned(
        bottom: -35,
        left: 20,
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Image.asset(
            AppAssets.myProfileImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(
        right: 20,
        bottom: -30,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            AppAssets.edit,
          ),
        ),
      ),
    ]);
  }
}
