import 'package:cast_in/models/post_model.dart';
import 'package:cast_in/models/user_model.dart';
import 'package:cast_in/services/supabase_service.dart';
import 'package:cast_in/utils/helpers.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final SupabaseService _supabaseService = Get.find<SupabaseService>();

  UserModel? userProfile;
  List<PostModel> posts = [];
  bool isLoading = true;
  int followersCount = 0;
  int followingCount = 0;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      isLoading = true;
      update();

      final currentUserId = _supabaseService.user?.id;
      if (currentUserId == null) return;

      // Load user profile
      userProfile = await _supabaseService.getUserProfile(currentUserId);
      if (userProfile?.profileImageUrl != null) {
        userProfile = userProfile?.copyWith(
            profileImageUrl: _supabaseService.getPublicUrl('profile_images', userProfile!.profileImageUrl!));
      }

      // Load followers and following counts
      final followers = await _supabaseService.getFollowers(currentUserId);
      final following = await _supabaseService.getFollowing(currentUserId);

      followersCount = followers.length;
      followingCount = following.length;

      // Load user posts
      posts = await _supabaseService.getPosts();

      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      // Handle error appropriately
      Helpers.appDebugger('Error loading profile: $e');
    }
  }
}
