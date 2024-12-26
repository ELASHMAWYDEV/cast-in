import 'package:cast_in/ui/screens/messages/components/message.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxList<Message> messages = <Message>[].obs;
  final dateTime = DateTime.parse("2024-02-13 21:30:00").obs;

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    messages.add(Message(
      text: text,
      timestamp: DateTime.now(),
      isMe: true,
      senderName: 'You',
    ));
  }

  @override
  void onInit() {
    super.onInit();
    // Add sample messages
    messages.addAll([
      Message(
        text: "Hey, I'm Fins, Free now, U?",
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isMe: true,
        senderName: 'You',
      ),
      Message(
        text: "Hi, Good Morning",
        timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
        isMe: false,
        senderName: '',
      ),
    ]);
  }
}
