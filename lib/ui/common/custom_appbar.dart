import 'package:cast_in/ui/screens/main/main_controller.dart';
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
                if (Get.isRegistered<MainController>()) {
                  final controller = Get.find<MainController>();
                  if (controller.selectedIndex > 3) {
                    controller.goToScreen(controller.selectedMainIndex);
                  } else {
                    Get.back();
                  }
                } else {
                  Get.back();
                }
              },
              icon: Icon(
                Icons.keyboard_arrow_left_rounded,
              ),
              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppStyle.secondaryBgColor)),
              tooltip: "Back",
            )
          : SizedBox.shrink(),
      title: Text(
        title,
        style: AppStyle.appBarTextStyle,
      ),
      backgroundColor: AppStyle.primaryBgColor,
      surfaceTintColor: AppStyle.primaryBgColor,
      actions: trailing?.map((element) => Padding(padding: EdgeInsets.only(right: 15), child: element)).toList(),
    );
  }
}
