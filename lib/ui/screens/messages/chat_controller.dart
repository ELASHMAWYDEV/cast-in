import 'package:cast_in/ui/screens/messages/components/message.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var messages = <Message>[].obs;

  void sendMessage(String text, bool isMe) {
    messages.add(
      Message(
        text: text,
        isMe: isMe,
        timestamp: DateTime.now(),
      ),
    );
  }
}
