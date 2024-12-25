import 'package:cast_in/ui/common/custom_appbar.dart';
import 'package:cast_in/ui/common/send_message_widegt.dart';
import 'package:cast_in/ui/screens/messages/components/chat_Bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat_controller.dart';

class ChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: ('Samaira'),
        isBackBtnEnabled: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final message = chatController.messages[index];
                  return Align(
                    alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: ChatBubble(
                      text: message.text,
                      time: message.timestamp,
                      isMe: message.isMe,
                    ),
                  );
                },
              ),
            ),
          ),
          // Input Section
          SendMessageWidegt(withAddIcon: true),
        ],
      ),
    );
  }
}
