import 'package:cast_in/utils/app_style.dart';
import 'package:flutter/material.dart';

class CustomTitleAndSuptitle extends StatelessWidget {
  final String title;
  final String suptitle;
  const CustomTitleAndSuptitle({super.key, required this.title, required this.suptitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyle.headingTextStyle2,
        ),
        SizedBox(height: 5),
        Text(suptitle, style: AppStyle.bodyTextStyle2),
      ],
    );
  }
}
