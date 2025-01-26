import 'package:get/get.dart';

class StatisticsController extends GetxController {
  bool isLoading = true;

  // User Statistics
  int dailyActiveUsers = 0;
  int totalModels = 0;
  int totalClients = 0;
  int newUsersToday = 0;
  double userGrowthRate = 0;

  // Engagement Statistics
  int totalPosts = 0;
  int postsToday = 0;
  int totalLikes = 0;
  int totalComments = 0;
  double avgEngagementRate = 0;

  // Platform Health
  int reportedUsers = 0;
  int reportedPosts = 0;
  int bannedUsers = 0;
  double platformHealth = 0;

  // Activity Data
  List<Map<String, dynamic>> userActivityData = [];
  List<Map<String, dynamic>> postActivityData = [];
  List<Map<String, dynamic>> engagementData = [];

  @override
  void onInit() {
    super.onInit();
    fetchStatistics();
  }

  Future<void> fetchStatistics() async {
    isLoading = true;
    update();

    try {
      // TODO: Implement API calls to fetch statistics
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Mock data for user statistics
      dailyActiveUsers = 150;
      totalModels = 500;
      totalClients = 1200;
      newUsersToday = 25;
      userGrowthRate = 5.2; // 5.2% growth

      // Mock data for engagement statistics
      totalPosts = 3500;
      postsToday = 120;
      totalLikes = 15000;
      totalComments = 8500;
      avgEngagementRate = 4.8; // 4.8% engagement rate

      // Mock data for platform health
      reportedUsers = 45;
      reportedPosts = 78;
      bannedUsers = 23;
      platformHealth = 98.5; // 98.5% platform health

      // Mock data for graphs
      userActivityData = List.generate(
          7,
          (index) => {
                'date': DateTime.now().subtract(Duration(days: 6 - index)),
                'users': (100 + index * 10),
              });

      postActivityData = List.generate(
          7,
          (index) => {
                'date': DateTime.now().subtract(Duration(days: 6 - index)),
                'posts': (50 + index * 5),
              });

      engagementData = List.generate(
          7,
          (index) => {
                'date': DateTime.now().subtract(Duration(days: 6 - index)),
                'engagement': (3 + index * 0.5),
              });
    } catch (e) {
      print('Error fetching statistics: $e');
    } finally {
      isLoading = false;
      update();
    }
  }
}
