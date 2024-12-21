import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';

enum ButtonType { primary, outline }

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.fullWidth = false,
      this.buttonType = ButtonType.primary});

  final VoidCallback onPressed;
  final String title;
  final bool fullWidth;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      decoration: BoxDecoration(
        color: buttonType == ButtonType.primary ? null : Colors.transparent,
        border: Border.all(color: buttonType == ButtonType.outline ? AppStyle.primaryColor : Colors.transparent),
        gradient: buttonType == ButtonType.outline
            ? null
            : LinearGradient(
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
            padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12, horizontal: 50)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
          ),
          child: Text(title,
              style: AppStyle.buttonTextStyle.copyWith(
                  color: buttonType == ButtonType.outline ? AppStyle.primaryColor : AppStyle.primaryBgColor))),
    );
  }
}
