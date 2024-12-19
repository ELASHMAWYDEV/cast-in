import 'package:cast_in/utils/app_images.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool withIcon;
  final VoidCallback? onBackPressed;
  final List<Widget>? trailing;

  const CustomAppBar({
    super.key,
    required this.withIcon,
    required this.title,
    this.onBackPressed,
    this.trailing,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: withIcon == true
            ? Image.asset(AppImages.appBarIcon)
            : SizedBox.shrink(),
      ),
      title: Text(title,
          style: AppStyle.headingTextStyle1.copyWith(
            fontSize: 40,
          )),
      actions: trailing,
    );
  }
}
