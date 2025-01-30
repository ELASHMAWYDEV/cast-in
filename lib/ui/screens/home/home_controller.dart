import 'package:cast_in/models/post_model.dart';
import 'package:cast_in/services/supabase_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _supabaseService = Get.find<SupabaseService>();
  bool isLoading = false;
  List<PostModel> posts = <PostModel>[];

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      isLoading = true;
      update();

      posts = await _supabaseService.getPosts();
    } catch (e) {
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
