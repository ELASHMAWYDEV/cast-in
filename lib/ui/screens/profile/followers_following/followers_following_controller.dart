import 'package:get/get.dart';

class FollowersFollowingController extends GetxController {
  final RxInt currentTabIndex = 0.obs;
  final RxString searchQuery = ''.obs;
  final RxList<Map<String, dynamic>> followers = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> following = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
  }

  void loadDummyData() {
    followers.addAll([
      {'name': 'Belle Benson', 'username': 'belle_benson', 'isFollowing': false},
      {'name': 'Myley Corbyn', 'username': 'belle_benson', 'isFollowing': false},
    ]);

    following.addAll([
      {'name': 'Belle Benson', 'username': 'belle_benson', 'isFollowing': true},
      {'name': 'Myley Corbyn', 'username': 'belle_benson', 'isFollowing': true},
    ]);
  }

  void setCurrentTabIndex(int index) {
    currentTabIndex.value = index;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void toggleFollow(int index, bool isFollowersTab) {
    if (isFollowersTab) {
      followers[index]['isFollowing'] = !followers[index]['isFollowing'];
      followers.refresh();
    } else {
      following[index]['isFollowing'] = !following[index]['isFollowing'];
      following.refresh();
    }
  }
}
