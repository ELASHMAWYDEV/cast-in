import 'package:cast_in/ui/common/custom_appbar.dart';
import 'package:cast_in/ui/screens/admin/components/admin_drawer.dart';
import 'package:cast_in/utils/style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'statistics_controller.dart';

class StatisticsScreen extends StatelessWidget {
  StatisticsScreen({super.key});

  final StatisticsController controller = Get.put(StatisticsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatisticsController>(
      builder: (_) => Scaffold(
        appBar: CustomAppBar(
          title: "Statistics",
          isBackBtnEnabled: false,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer: const AdminDrawer(),
        body: Skeletonizer(
          enabled: controller.isLoading,
          child: RefreshIndicator(
            onRefresh: () async => await controller.fetchStatistics(),
            color: AppStyle.secondaryColor,
            backgroundColor: AppStyle.primaryBgColor,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('User Overview'),
                  _buildUserStats(),
                  const SizedBox(height: 30),
                  _buildSectionTitle('User Activity'),
                  _buildActivityGraph(),
                  const SizedBox(height: 30),
                  _buildSectionTitle('Engagement Metrics'),
                  _buildEngagementStats(),
                  const SizedBox(height: 30),
                  _buildSectionTitle('Platform Health'),
                  _buildPlatformHealth(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: AppStyle.primaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserStats() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: "Total Models",
                value: controller.totalModels.toString(),
                icon: Icons.person_outline,
                color: AppStyle.secondaryColor,
                subtitle: "+${controller.newUsersToday} today",
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _buildStatCard(
                title: "Total Clients",
                value: controller.totalClients.toString(),
                icon: Icons.groups_outlined,
                color: AppStyle.primaryColor,
                subtitle: "${controller.userGrowthRate}% growth",
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _buildStatCard(
          title: "Daily Active Users",
          value: controller.dailyActiveUsers.toString(),
          icon: Icons.trending_up,
          color: Colors.green,
          subtitle: "Active now",
          fullWidth: true,
        ),
      ],
    );
  }

  Widget _buildEngagementStats() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: "Total Posts",
                value: controller.totalPosts.toString(),
                icon: Icons.post_add,
                color: Colors.blue,
                subtitle: "+${controller.postsToday} today",
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _buildStatCard(
                title: "Engagement Rate",
                value: "${controller.avgEngagementRate}%",
                icon: Icons.thumb_up_outlined,
                color: Colors.orange,
                subtitle: "${controller.totalLikes} likes",
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _buildStatCard(
          title: "Total Comments",
          value: controller.totalComments.toString(),
          icon: Icons.comment_outlined,
          color: Colors.purple,
          subtitle: "Active discussions",
          fullWidth: true,
        ),
      ],
    );
  }

  Widget _buildPlatformHealth() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: "Reported Users",
                value: controller.reportedUsers.toString(),
                icon: Icons.warning_outlined,
                color: Colors.orange,
                subtitle: "Needs review",
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _buildStatCard(
                title: "Banned Users",
                value: controller.bannedUsers.toString(),
                icon: Icons.block,
                color: Colors.red,
                subtitle: "Total bans",
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _buildStatCard(
          title: "Platform Health",
          value: "${controller.platformHealth}%",
          icon: Icons.health_and_safety_outlined,
          color: Colors.green,
          subtitle: "${controller.reportedPosts} posts reported",
          fullWidth: true,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String subtitle,
    bool fullWidth = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            value,
            style: TextStyle(
              fontSize: fullWidth ? 32 : 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              subtitle,
              style: TextStyle(
                color: color.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityGraph() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppStyle.grey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildGraphLegend(AppStyle.secondaryColor, 'Users'),
              const SizedBox(width: 15),
              _buildGraphLegend(Colors.blue, 'Posts'),
              const SizedBox(width: 15),
              _buildGraphLegend(Colors.orange, 'Engagement'),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 20,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppStyle.grey.withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= controller.userActivityData.length) {
                          return const SizedBox();
                        }
                        final date = controller.userActivityData[value.toInt()]['date'] as DateTime;
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${date.day}/${date.month}',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppStyle.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  _createLineBarsData(
                    data: controller.userActivityData,
                    key: 'users',
                    color: AppStyle.secondaryColor,
                  ),
                  _createLineBarsData(
                    data: controller.postActivityData,
                    key: 'posts',
                    color: Colors.blue,
                  ),
                  _createLineBarsData(
                    data: controller.engagementData,
                    key: 'engagement',
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGraphLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            color: AppStyle.grey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  LineChartBarData _createLineBarsData({
    required List<Map<String, dynamic>> data,
    required String key,
    required Color color,
  }) {
    return LineChartBarData(
      spots: data
          .asMap()
          .entries
          .map((entry) => FlSpot(
                entry.key.toDouble(),
                entry.value[key].toDouble(),
              ))
          .toList(),
      isCurved: true,
      color: color,
      barWidth: 3,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        color: color.withOpacity(0.1),
      ),
    );
  }
}
