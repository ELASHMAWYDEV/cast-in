import 'package:cast_in/ui/screens/messages/chat/chat_controller.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendMessageWidegt extends StatelessWidget {
  final bool withAddIcon;
  SendMessageWidegt({super.key, required this.withAddIcon});

  final TextEditingController _controller = TextEditingController();
  final FocusNode commentFocusNode = FocusNode();
  final RxList<String> suggestions = <String>[].obs;
  final List<String> allUsers = ['John', 'Jane', 'Alex', 'Alice', 'Michael']; // Example user list

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      commentFocusNode.requestFocus();
    });
    return Column(
      children: [
        Obx(() {
          // Show suggestions dropdown
          if (suggestions.isNotEmpty) {
            return Container(
              color: Colors.white,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(suggestions[index]),
                    onTap: () {
                      _insertTag(suggestions[index]);
                      suggestions.clear(); // Clear suggestions after selection
                    },
                  );
                },
              ),
            );
          }
          return SizedBox.shrink();
        }),
        Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: AppStyle.grey.withValues(alpha: .2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                if (withAddIcon)
                  IconButton(
                    icon: Icon(Icons.add, color: AppStyle.secondaryTextColor),
                    onPressed: () {
                      // Handle attachments
                    },
                  ),
                Expanded(
                  child: TextField(
                    focusNode: commentFocusNode,
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Message...',
                      hintStyle: AppStyle.bodyTextStyle2.copyWith(
                        color: AppStyle.grey,
                      ),
                      filled: true,
                      fillColor: AppStyle.primaryBgColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: _handleInputChange,
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: AppStyle.secondaryTextColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: GestureDetector(
                      onTap: () {
                        if (_controller.text.isNotEmpty) {
                          Get.find<ChatController>().sendMessage(_controller.text);
                          _controller.clear();
                        }
                      },
                      child: Text(
                        'send',
                        style: TextStyle(color: AppStyle.primaryBgColor),
                      ),
                    ),
                  )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _handleInputChange(String value) {
    // Check if `@` is typed
    if (value.contains('@')) {
      final lastIndex = value.lastIndexOf('@');
      final query = value.substring(lastIndex + 1).trim();

      // Filter user list based on the query
      if (query.isNotEmpty) {
        suggestions.value = allUsers.where((user) => user.toLowerCase().startsWith(query.toLowerCase())).toList();
      } else {
        suggestions.clear();
      }
    } else {
      suggestions.clear();
    }
  }

  void _insertTag(String username) {
    final text = _controller.text;
    final lastIndex = text.lastIndexOf('@');
    if (lastIndex != -1) {
      final newText = text.substring(0, lastIndex + 1) + username + ' ';
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
  }
}
