import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';

class SendMessageWidegt extends StatelessWidget {
  final bool withAddIcon;
  SendMessageWidegt({super.key, required this.withAddIcon});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: AppStyle.grey.withValues(alpha: 0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              withAddIcon == true
                  ? IconButton(
                      icon: Icon(Icons.add, color: AppStyle.secondaryTextColor),
                      onPressed: () {
                        // Handle attachments
                      },
                    )
                  : SizedBox.shrink(),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Message...',
                    hintStyle: AppStyle.bodyTextStyle2.copyWith(
                      color: AppStyle.grey,
                    ),
                    filled: true,
                    fillColor: AppStyle.primaryBgColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppStyle.secondaryTextColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'send',
                    style: TextStyle(color: AppStyle.primaryBgColor),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
