import 'package:cast_in/ui/screens/messages/components/message_card.dart';
import 'package:cast_in/ui/screens/messages/messages/messages_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MessagesScreen extends StatelessWidget {
  MessagesScreen({super.key});

  final MessagesController controller = Get.put(MessagesController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessagesController>(builder: (_) {
      return SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Skeletonizer(
          enabled: controller.isLoading,
          child: Column(
            children: List.generate(
              10,
              (int index) => MessageCard(),
            ),
          ),
        ),
      ));
    });
  }
}
