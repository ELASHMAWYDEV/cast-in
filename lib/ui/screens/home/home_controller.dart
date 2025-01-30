import 'package:cast_in/models/post_model.dart';
import 'package:cast_in/services/supabase_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _supabaseService = Get.find<SupabaseService>();
  bool isLoading = false;
  RxList<PostModel> posts = <PostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      isLoading = true;
      update();

      final response = await _supabaseService.client.from('posts').select('''
            *,
            profiles:user_id (
              full_name,
              user_name,
              avatar_url
            )
          ''').order('created_at', ascending: false);

      // Use the fromMap factory constructor
      posts.value = (response as List<dynamic>).map((post) => PostModel.fromMap(post)).toList();
    } catch (e) {
      print('Error fetching posts: $e');
      Get.snackbar(
        'Error',
        'Failed to load posts',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
      update();
    }
  }
}
