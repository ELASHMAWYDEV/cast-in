import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackBtnEnabled;
  final List<Widget>? trailing;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isBackBtnEnabled = false,
    this.trailing,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leadingWidth: 80,
      leading: isBackBtnEnabled
          ? IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.keyboard_arrow_left_rounded),
              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppStyle.secondaryBgColor)),
            )
          : SizedBox.shrink(),
      title: Text(title,
          style: AppStyle.headingTextStyle1.copyWith(
            fontSize: 40,
          )),
      backgroundColor: AppStyle.primaryBgColor,
      surfaceTintColor: AppStyle.primaryBgColor,
      actions: trailing,
    );
  }
}
