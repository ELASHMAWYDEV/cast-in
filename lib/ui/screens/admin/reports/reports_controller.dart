import 'package:get/get.dart';
import 'package:cast_in/models/reported_post_model.dart';

class ReportsController extends GetxController {
  bool isLoading = false;
  String? loadingPostId;
  List<ReportedPost> reportedPosts = [];

  @override
  void onInit() {
    super.onInit();
    fetchReportedPosts();
  }

  Future<void> fetchReportedPosts() async {
    isLoading = true;
    update();

    try {
      // TODO: Implement API call to fetch reported posts
      await Future.delayed(Duration(seconds: 2)); // Simulated delay
      reportedPosts = []; // Clear existing posts
    } catch (e) {
      print('Error fetching reports: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  void viewUserProfile(String userId) {
    // TODO: Implement navigation to user profile
    print('Viewing profile of user: $userId');
  }

  void viewPost(String postId) {
    // TODO: Implement navigation to post detail
    print('Viewing post: $postId');
  }

  Future<void> banUser(String userId, String userName) async {
    loadingPostId = userId;
    update();

    try {
      // TODO: Implement API call to ban user
      await Future.delayed(Duration(seconds: 2)); // Simulated delay

      Get.snackbar(
        'Success',
        'User $userName has been banned',
        snackPosition: SnackPosition.BOTTOM,
      );

      // Refresh reports list after banning
      await fetchReportedPosts();
    } catch (e) {
      print('Error banning user: $e');
      Get.snackbar(
        'Error',
        'Failed to ban user $userName',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      loadingPostId = null;
      update();
    }
  }
}
