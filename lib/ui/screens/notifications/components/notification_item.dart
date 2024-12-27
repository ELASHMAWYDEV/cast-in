import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String profileImage;
  final String username;
  final String action;
  final String timeAgo;

  const NotificationItem({
    super.key,
    required this.profileImage,
    required this.username,
    required this.action,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(profileImage),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                      TextSpan(
                        text: username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' $action'),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  timeAgo,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
