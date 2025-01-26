import 'package:cast_in/utils/app_router.dart';
import 'package:get/get.dart';

enum UserType { all, models, clients }

class UserData {
  final String id;
  final String name;
  final String username;
  final String avatarUrl;
  final int followers;
  final bool isBanned;
  final UserType type;

  UserData({
    required this.id,
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.followers,
    required this.isBanned,
    required this.type,
  });
}

class UserManagementController extends GetxController {
  bool isLoading = true;
  String? loadingUserId; // Track which user's ban action is loading
  UserType selectedTab = UserType.all;
  String searchQuery = '';
  List<UserData> users = [];
  List<UserData> filteredUsers = [];

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void setSelectedTab(UserType type) {
    selectedTab = type;
    filterUsers();
    update();
  }

  void setSearchQuery(String query) {
    searchQuery = query;
    filterUsers();
    update();
  }

  void filterUsers() {
    filteredUsers = users.where((user) {
      bool matchesTab = selectedTab == UserType.all || user.type == selectedTab;
      bool matchesSearch = user.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          user.username.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesTab && matchesSearch;
    }).toList();
  }

  Future<void> fetchUsers() async {
    isLoading = true;
    update();

    try {
      // TODO: Implement API call to fetch users
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Mock data
      users = [
        UserData(
          id: '1',
          name: 'John Model',
          username: '@johnmodel',
          avatarUrl: 'https://i.pravatar.cc/150?img=1',
          followers: 1200,
          isBanned: false,
          type: UserType.models,
        ),
        UserData(
          id: '2',
          name: 'Sarah Client',
          username: '@sarahclient',
          avatarUrl: 'https://i.pravatar.cc/150?img=2',
          followers: 300,
          isBanned: true,
          type: UserType.clients,
        ),
        // Add more mock users as needed
      ];
      filterUsers();
    } catch (e) {
      print('Error fetching users: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> toggleUserBan(String userId) async {
    loadingUserId = userId;
    update();

    try {
      // TODO: Implement API call to ban/unban user
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      final userIndex = users.indexWhere((u) => u.id == userId);
      if (userIndex != -1) {
        final user = users[userIndex];
        users[userIndex] = UserData(
          id: user.id,
          name: user.name,
          username: user.username,
          avatarUrl: user.avatarUrl,
          followers: user.followers,
          isBanned: !user.isBanned,
          type: user.type,
        );
        filterUsers();
      }
    } catch (e) {
      print('Error toggling user ban: $e');
    } finally {
      loadingUserId = null;
      update();
    }
  }

  void viewUserProfile(String userId) {
    final user = users.firstWhere((u) => u.id == userId);
    Get.toNamed(AppRouter.VIEW_PROFILE, arguments: {'userId': userId});
  }
}
