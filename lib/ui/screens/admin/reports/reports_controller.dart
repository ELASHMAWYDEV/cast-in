import 'package:cast_in/utils/app_router.dart';
import 'package:get/get.dart';

class ReportedPost {
  final String id;
  final String reporterId;
  final String reporterName;
  final String postOwnerId;
  final String postOwnerName;
  final String postId;
  final DateTime reportedAt;
  final String reason;

  ReportedPost({
    required this.id,
    required this.reporterId,
    required this.reporterName,
    required this.postOwnerId,
    required this.postOwnerName,
    required this.postId,
    required this.reportedAt,
    required this.reason,
  });
}

class ReportsController extends GetxController {
  final RxList<ReportedPost> _reportedPosts = <ReportedPost>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _loadingPostId = ''.obs;

  List<ReportedPost> get reportedPosts => _reportedPosts;
  bool get isLoading => _isLoading.value;
  String get loadingPostId => _loadingPostId.value;

  @override
  void onInit() {
    super.onInit();
    fetchReportedPosts();
  }

  Future<void> fetchReportedPosts() async {
    try {
      _isLoading.value = true;
      update();

      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 2));

      _reportedPosts.value = [
        ReportedPost(
          id: '1',
          reporterId: 'user1',
          reporterName: 'John Doe',
          postOwnerId: 'user2',
          postOwnerName: 'Jane Smith',
          postId: 'post1',
          reportedAt: DateTime.now().subtract(const Duration(hours: 2)),
          reason: 'Inappropriate content',
        ),
        ReportedPost(
          id: '2',
          reporterId: 'user3',
          reporterName: 'Alice Johnson',
          postOwnerId: 'user4',
          postOwnerName: 'Bob Wilson',
          postId: 'post2',
          reportedAt: DateTime.now().subtract(const Duration(days: 1)),
          reason: 'Spam',
        ),
      ];
    } catch (e) {
      print('Error fetching reported posts: $e');
      // TODO: Handle error appropriately
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  Future<void> banUser(String userId, String userName) async {
    try {
      _loadingPostId.value = userId;
      update();

      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 2));

      // Remove all reports for this user after banning
      _reportedPosts.removeWhere((post) => post.postOwnerId == userId);

      Get.snackbar(
        'Success',
        'User $userName has been banned',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error banning user: $e');
      Get.snackbar(
        'Error',
        'Failed to ban user $userName',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _loadingPostId.value = '';
      update();
    }
  }

  void viewUserProfile(String userId) {
    // TODO: Implement navigation to user profile
    print('Navigate to user profile: $userId');
  }

  void viewPost(String postId) {
    // TODO: Implement navigation to post details
    print('Navigate to post details: $postId');
  }
}
