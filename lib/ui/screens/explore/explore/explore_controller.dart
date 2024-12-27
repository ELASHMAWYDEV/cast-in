import 'package:get/get.dart';

class ExploreController extends GetxController {
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    isLoading = true;
    update();
    // TODO: Implement actual post fetching logic
    await Future.delayed(const Duration(seconds: 3));
    isLoading = false;
    update();
  }
}
