import 'package:cast_in/ui/common/custom_appbar.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Messages",
      ),
      body: SingleChildScrollView(
        child: Column(
          // Create a list of messaging people
          children: List.generate(
            10,
            (int index) => ListTile(
              leading: CircleAvatar(
                child: Text("A"),
              ),
              title: Text("Person $index"),
              subtitle: Text("Message $index"),
              onTap: () {
                // Navigate to the chat screen
              },
            ),
          ),
        ),
      ),
    );
  }
}
