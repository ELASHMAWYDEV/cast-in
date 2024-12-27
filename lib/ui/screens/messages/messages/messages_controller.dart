import 'package:get/get.dart';

class MessagesController extends GetxController {
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    isLoading = true;
    update();
    // TODO: Implement actual message fetching logic
    await Future.delayed(const Duration(seconds: 3));
    isLoading = false;
    update();
  }
}
