import 'package:cast_in/utils/app_style.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String sender;
  final String text;
  final DateTime time;
  final bool isMe;

  const ChatBubble({
    super.key,
    required this.text,
    required this.time,
    required this.isMe,
    required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              sender,
              style: AppStyle.bodyTextStyle1.copyWith(
                fontSize: 13,
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: BoxDecoration(
                color: isMe ? AppStyle.primaryTextColor : AppStyle.secondaryTextColor,
                borderRadius: isMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(10), bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))
                    : BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: AppStyle.subTitleStyle1.copyWith(
                    color: AppStyle.primaryBgColor,
                  ),
                ),
              ],
            ),
          ),
          isMe
              ? Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'Sent',
                    style: AppStyle.bodyTextStyle3.copyWith(
                      color: AppStyle.primaryTextColor,
                    ),
                  ),
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
