import 'package:cast_in/ui/common/custom_appbar.dart';
import 'package:cast_in/ui/screens/admin/components/admin_drawer.dart';
import 'package:cast_in/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'user_management_controller.dart';

class UserManagementScreen extends StatelessWidget {
  UserManagementScreen({super.key});

  final UserManagementController controller = Get.put(UserManagementController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserManagementController>(
      builder: (_) => Scaffold(
        appBar: CustomAppBar(
          title: "User Management",
          isBackBtnEnabled: false,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer: const AdminDrawer(),
        body: Column(
          children: [
            _buildTabs(),
            _buildSearchBar(),
            Expanded(
              child: Skeletonizer(
                enabled: controller.isLoading,
                child: RefreshIndicator(
                  onRefresh: () async => await controller.fetchUsers(),
                  color: AppStyle.secondaryColor,
                  backgroundColor: AppStyle.primaryBgColor,
                  child: _buildUserList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppStyle.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: UserType.values.map((type) {
          bool isSelected = controller.selectedTab == type;
          return Expanded(
            child: GestureDetector(
              onTap: () => controller.setSelectedTab(type),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppStyle.secondaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  type.name.capitalize!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppStyle.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onChanged: controller.setSearchQuery,
        decoration: InputDecoration(
          hintText: 'Search users...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppStyle.grey.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppStyle.grey.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppStyle.secondaryColor),
          ),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    if (controller.filteredUsers.isEmpty) {
      return Center(
        child: Text(
          controller.searchQuery.isEmpty ? 'No users found' : 'No users match your search',
          style: TextStyle(color: AppStyle.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: controller.filteredUsers.length,
      itemBuilder: (context, index) {
        final user = controller.filteredUsers[index];
        return _buildUserCard(user);
      },
    );
  }

  Widget _buildUserCard(UserData user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(user.avatarUrl),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user.username,
                  style: TextStyle(
                    color: AppStyle.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${user.followers} followers',
                  style: TextStyle(
                    color: AppStyle.secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              OutlinedButton(
                onPressed: () => controller.viewUserProfile(user.id),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppStyle.secondaryColor,
                  side: BorderSide(color: AppStyle.secondaryColor),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                child: const Text('View'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => controller.toggleUserBan(user.id),
                style: TextButton.styleFrom(
                  foregroundColor: user.isBanned ? Colors.green : Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                child: controller.loadingUserId == user.id
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            user.isBanned ? Colors.green : Colors.red,
                          ),
                        ),
                      )
                    : Text(user.isBanned ? 'Unban' : 'Ban'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
