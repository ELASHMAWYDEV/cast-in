import 'package:cast_in/ui/screens/messages/chat/chat_controller.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendMessageWidegt extends StatelessWidget {
  final bool withAddIcon;
  SendMessageWidegt({super.key, required this.withAddIcon});

  final TextEditingController _controller = TextEditingController();
  final FocusNode commentFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      commentFocusNode.requestFocus();
    });
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: AppStyle.grey.withValues(alpha: 0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
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
              focusNode: commentFocusNode,
              controller: _controller,
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
            )),
            SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                color: AppStyle.secondaryTextColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: GestureDetector(
                  onTap: () {
                    if (_controller.text.isNotEmpty) {
                      Get.find<ChatController>().sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                  child: Text(
                    'send',
                    style: TextStyle(color: AppStyle.primaryBgColor),
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
