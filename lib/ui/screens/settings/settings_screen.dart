import 'package:cast_in/services/supabase_service.dart';
import 'package:cast_in/ui/screens/settings/components/setting_item.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              _buildHeaderText('Account Center'),
              SettingItem(
                title: 'Change Password',
                icon: AppAssets.changePasswordIcon,
                onTap: () {},
              ),
              SettingItem(
                title: 'Change Phone Number',
                icon: AppAssets.changePhoneIcon,
                onTap: () {},
              ),
            ],
          ),
        ),
        Divider(
          color: AppStyle.secondaryBgColor,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              _buildHeaderText('Support'),
              SettingItem(
                title: 'Help',
                icon: AppAssets.helpIcon,
                onTap: () {},
              ),
              SettingItem(
                title: 'Privacy Policy',
                icon: AppAssets.privacyIcon,
                onTap: () {},
              ),
              SettingItem(
                title: 'Terms & Use',
                icon: AppAssets.privacyIcon,
                onTap: () {},
              ),
            ],
          ),
        ),
        Divider(
          color: AppStyle.secondaryBgColor,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              _buildHeaderText('More'),
              SettingItem(
                title: 'Logout',
                icon: AppAssets.logoutIcon,
                onTap: () {
                  Get.find<SupabaseService>().signOut();
                  Get.offAllNamed(AppRouter.LOGIN);
                },
              ),
              SettingItem(
                title: 'Delete Account',
                icon: AppAssets.deleteAccountIcon,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderText(String title) {
    return Text(title, style: AppStyle.subTitleStyle1.copyWith(fontWeight: FontWeight.w600, fontSize: 18));
  }
}
