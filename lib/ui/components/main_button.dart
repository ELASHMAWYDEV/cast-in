import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.fullWidth = false});

  final VoidCallback onPressed;
  final String title;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppStyle.primaryColor, AppStyle.secondaryColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.transparent),
            shadowColor: WidgetStatePropertyAll(Colors.transparent),
            padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(vertical: 15, horizontal: 50)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
          ),
          child: Text(title, style: AppStyle.buttonTextStyle)),
    );
  }
}
