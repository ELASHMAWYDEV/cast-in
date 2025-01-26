import 'package:get/get.dart';

class ExploreViewAllController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    loadPosts();
  }

  Future<void> loadPosts() async {
    _isLoading = true;
    update();

    // TODO: Implement API call to fetch posts based on type
    await Future.delayed(Duration(seconds: 2)); // Simulate API call

    _isLoading = false;
    update();
  }
}
