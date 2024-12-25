import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final DateTime time;
  final bool isMe;

  const ChatBubble({
    super.key,
    required this.text,
    required this.time,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isMe ? Colors.black : Colors.purple,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            "${time.hour}:${time.minute.toString().padLeft(2, '0')}",
            style: const TextStyle(color: Colors.white70, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
