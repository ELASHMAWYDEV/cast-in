import 'package:cast_in/ui/common/custom_appbar.dart';
import 'package:cast_in/ui/common/send_message_widegt.dart';
import 'package:cast_in/ui/screens/messages/components/chat_bubble.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'chat_controller.dart';

class ChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  ChatScreen({super.key});

  String formatDateTime(DateTime dateTime) {
    return DateFormat('E, d MMM').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (context) {
      return Scaffold(
        appBar: CustomAppBar(
          title: ('Samaira'),
          isBackBtnEnabled: true,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const ScrollPhysics(
                  parent: BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.fast,
                  ),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: Get.height * 0.8,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          formatDateTime(chatController.dateTime.value),
                          style: AppStyle.bodyTextStyle3,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: chatController.messages
                            .map(
                              (message) => Align(
                                alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
                                child: ChatBubble(
                                  sender: message.senderName,
                                  text: message.text,
                                  time: message.timestamp,
                                  isMe: message.isMe,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SendMessageWidegt(
              withAddIcon: true,
            )
          ],
        ),
      );
    });
  }
}
