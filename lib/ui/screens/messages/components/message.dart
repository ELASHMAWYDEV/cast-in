class Message {
  final String text;
  final DateTime timestamp;
  final bool isMe;
  final String senderName;
  final String? imageUrl;

  Message({
    required this.text,
    required this.timestamp,
    required this.isMe,
    required this.senderName,
    this.imageUrl,
  });
}
