import 'package:cast_in/models/reported_post_model.dart';
import 'package:cast_in/ui/common/custom_appbar.dart';
import 'package:cast_in/ui/screens/admin/components/admin_drawer.dart';
import 'package:cast_in/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'reports_controller.dart';

class ReportsScreen extends StatelessWidget {
  ReportsScreen({super.key});

  final ReportsController controller = Get.put(ReportsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportsController>(
      builder: (_) => Scaffold(
        appBar: CustomAppBar(
          title: "Reports",
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
            onRefresh: () async => await controller.fetchReportedPosts(),
            color: AppStyle.secondaryColor,
            backgroundColor: AppStyle.primaryBgColor,
            child: controller.reportedPosts.isEmpty ? _buildEmptyState() : _buildReportsList(),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 64,
            color: AppStyle.grey.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No reported posts',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppStyle.grey.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'All clear! No posts have been reported.',
            style: TextStyle(
              color: AppStyle.grey.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: controller.reportedPosts.length,
      itemBuilder: (context, index) {
        final report = controller.reportedPosts[index];
        return _buildReportCard(report);
      },
    );
  }

  Widget _buildReportCard(ReportedPost report) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppStyle.grey.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                color: AppStyle.primaryTextColor,
              ),
              children: [
                TextSpan(
                  text: report.reporterName,
                  style: TextStyle(
                    color: AppStyle.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () => controller.viewUserProfile(report.reporterId),
                ),
                const TextSpan(text: ' reported '),
                TextSpan(
                  text: "${report.postOwnerName}'s",
                  style: TextStyle(
                    color: AppStyle.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () => controller.viewUserProfile(report.postOwnerId),
                ),
                const TextSpan(text: ' post '),
                TextSpan(
                  text: timeago.format(report.reportedAt),
                  style: TextStyle(
                    color: AppStyle.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              report.reason,
              style: TextStyle(
                color: Colors.red.shade700,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => controller.viewPost(report.postId),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppStyle.secondaryColor,
                    side: BorderSide(color: AppStyle.secondaryColor),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('View Post'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextButton(
                  onPressed: () => controller.banUser(
                    report.postOwnerId,
                    report.postOwnerName,
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: controller.loadingPostId == report.postOwnerId
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text('Ban ${report.postOwnerName}'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
