import 'package:cast_in/utils/app_style.dart';
import 'package:flutter/material.dart';

enum ButtonType { primary, outline }

class MainButton extends StatefulWidget {
  const MainButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    required this.title,
    this.fullWidth = false,
    this.buttonType = ButtonType.primary,
  });

  final Function() onPressed;
  final VoidCallback? onLongPress;
  final String title;
  final bool fullWidth;
  final ButtonType buttonType;

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  bool _isLoading = false;

  Future<void> _handlePress() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onPressed();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.fullWidth ? double.infinity : null,
      decoration: BoxDecoration(
        color: widget.buttonType == ButtonType.primary ? null : Colors.transparent,
        border: Border.all(color: widget.buttonType == ButtonType.outline ? AppStyle.primaryColor : Colors.transparent),
        gradient: widget.buttonType == ButtonType.outline
            ? null
            : LinearGradient(
                colors: [AppStyle.primaryColor, AppStyle.secondaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: ElevatedButton(
          onPressed: _handlePress,
          onLongPress: widget.onLongPress,
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
            shadowColor: const WidgetStatePropertyAll(Colors.transparent),
            padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12, horizontal: 50)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
          ),
          child: _isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        widget.buttonType == ButtonType.outline ? AppStyle.primaryColor : AppStyle.primaryBgColor),
                  ),
                )
              : Text(widget.title,
                  style: AppStyle.buttonTextStyle.copyWith(
                      color:
                          widget.buttonType == ButtonType.outline ? AppStyle.primaryColor : AppStyle.primaryBgColor))),
    );
  }
}
