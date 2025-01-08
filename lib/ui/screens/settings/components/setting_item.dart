import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final String icon;
  final String title;
  final void Function() onTap;
  const SettingItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(7),
      child: Padding(
        padding: const EdgeInsets.only(right: 6.0),
        child: Row(children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(color: AppStyle.lightGrey, borderRadius: BorderRadius.circular(7)),
            child: Image.asset(icon),
          ),
          SizedBox(width: 15),
          Text(
            title,
            style: AppStyle.subTitleStyle1,
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 15,
          )
        ]),
      ),
    );
  }
}
