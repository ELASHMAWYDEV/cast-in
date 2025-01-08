import 'package:cast_in/ui/screens/main/main_controller.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileAndBackgroundPhotos extends StatelessWidget {
  final bool editScreen;
  const ProfileAndBackgroundPhotos({super.key, required this.editScreen});

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
      editScreen == false
          ? Positioned(
              right: 20,
              bottom: -30,
              child: GestureDetector(
                onTap: () => Get.find<MainController>().goToScreen(MainRouter.EDIT_PROFILE),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    AppAssets.editIcon,
                  ),
                ),
              ),
            )
          : Positioned(
              right: 20,
              top: 10,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  AppAssets.editIcon,
                ),
              ),
            ),
    ]);
  }
}
