import 'package:cast_in/ui/screens/main/main_controller.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileAndBackgroundPhotos extends StatelessWidget {
  final bool editScreen;
  final String? profileImageUrl;
  final String? coverImageUrl;
  final VoidCallback? onEditProfileTap;
  final VoidCallback? onEditCoverTap;

  const ProfileAndBackgroundPhotos({
    super.key,
    required this.editScreen,
    this.profileImageUrl,
    this.coverImageUrl,
    this.onEditProfileTap,
    this.onEditCoverTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: coverImageUrl != null
                  ? NetworkImage(coverImageUrl!) as ImageProvider
                  : AssetImage(AppAssets.backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: -40,
          left: 20,
          child: GestureDetector(
            onTap: editScreen ? onEditProfileTap : null,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 4),
                borderRadius: BorderRadius.circular(100),
              ),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: profileImageUrl != null
                    ? NetworkImage(profileImageUrl!) as ImageProvider
                    : AssetImage(AppAssets.myProfileImage),
              ),
            ),
          ),
        ),
        if (!editScreen)
          Positioned(
            right: 20,
            bottom: -30,
            child: GestureDetector(
              onTap: () => Get.find<MainController>().goToScreen(MainRouter.EDIT_PROFILE),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppStyle.secondaryBgColor, width: 1),
                ),
                child: Image.asset(AppAssets.editIcon, width: 20),
              ),
            ),
          )
        else
          Positioned(
            right: 20,
            top: 10,
            child: GestureDetector(
              onTap: onEditCoverTap,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(AppAssets.editIcon),
              ),
            ),
          ),
      ],
    );
  }
}
