import 'package:cast_in/services/supabase_service.dart';
import 'package:cast_in/utils/app_router.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppStyle.primaryColor,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.admin_panel_settings,
                    size: 50,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Admin Panel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.analytics_outlined,
            title: 'Statistics',
            route: AppRouter.ADMIN_STATISTICS,
          ),
          _buildDrawerItem(
            icon: Icons.people_outline,
            title: 'User Management',
            route: AppRouter.ADMIN_USER_MANAGEMENT,
          ),
          const Spacer(),
          Divider(color: AppStyle.grey.withAlpha(10)),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: ElevatedButton.icon(
              onPressed: () {
                Get.find<SupabaseService>().signOut();
                Get.offAllNamed(AppRouter.LOGIN);
              },
              icon: const Icon(Icons.exit_to_app, color: Colors.white),
              label: const Text('Exit Admin Panel'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppStyle.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    String? route,
    VoidCallback? onTap,
  }) {
    final isSelected = route != null && Get.currentRoute == route;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppStyle.primaryColor : AppStyle.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppStyle.primaryColor : AppStyle.grey,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: onTap ?? () => Get.offAllNamed(route!),
      selected: isSelected,
      selectedTileColor: AppStyle.primaryColor.withOpacity(0.1),
    );
  }
}
