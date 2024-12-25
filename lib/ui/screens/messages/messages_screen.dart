import 'package:cast_in/ui/common/custom_appbar.dart';
import 'package:cast_in/ui/screens/messages/components/message_card.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Messages",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            children: List.generate(
              3,
              (int index) => MessageCard(),
            ),
          ),
        ),
      ),
    );
  }
}
