import 'package:cast_in/models/post_model.dart';
import 'package:cast_in/services/supabase_service.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _supabaseService = Get.find<SupabaseService>();
  bool isLoading = false;
  List<PostModel> posts = <PostModel>[
    PostModel(
      id: "1",
      name: "John Smith",
      username: "johnsmith",
      content: "Professional headshot and portfolio session",
      imageUrl: ['https://picsum.photos/400/600?random=1'],
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      likes: 24,
      comments: 5,
      contentType: PostContentType.image,
    ),
    PostModel(
      id: "2",
      name: "Sarah Wilson",
      username: "sarahw",
      content: "Fashion editorial shoot",
      imageUrl: ['https://picsum.photos/400/600?random=2'],
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      likes: 15,
      comments: 3,
      contentType: PostContentType.image,
    ),
    PostModel(
      id: "3",
      name: "Mike Johnson",
      username: "mikej",
      content: "Commercial modeling portfolio",
      imageUrl: ['https://picsum.photos/400/600?random=3'],
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      likes: 32,
      comments: 8,
      contentType: PostContentType.image,
    ),
    PostModel(
      id: "4",
      name: "Emily Brown",
      username: "emilyb",
      content: "Runway walk practice session",
      imageUrl: ['https://picsum.photos/400/600?random=4'],
      avatarUrl: 'https://i.pravatar.cc/150?img=4',
      likes: 45,
      comments: 12,
      contentType: PostContentType.image,
    ),
    PostModel(
      id: "5",
      name: "David Lee",
      username: "davidl",
      content: "Behind the scenes at photo shoot",
      imageUrl: ['https://picsum.photos/400/600?random=5'],
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
      likes: 28,
      comments: 6,
      contentType: PostContentType.image,
    ),
    PostModel(
      id: "6",
      name: "Lisa Chen",
      username: "lisac",
      content: "New portfolio additions",
      imageUrl: ['https://picsum.photos/400/600?random=6'],
      avatarUrl: 'https://i.pravatar.cc/150?img=6',
      likes: 37,
      comments: 9,
      contentType: PostContentType.image,
    ),
    PostModel(
      id: "7",
      name: "Robert Taylor",
      username: "robertt",
      content: "Studio lighting test shots",
      imageUrl: ['https://picsum.photos/400/600?random=7'],
      avatarUrl: 'https://i.pravatar.cc/150?img=7',
      likes: 19,
      comments: 4,
      contentType: PostContentType.image,
    ),
    PostModel(
      id: "8",
      name: "Amanda White",
      username: "amandaw",
      content: "Location scouting for next shoot",
      imageUrl: ['https://picsum.photos/400/600?random=8'],
      avatarUrl: 'https://i.pravatar.cc/150?img=8',
      likes: 22,
      comments: 7,
      contentType: PostContentType.image,
    ),
    PostModel(
      id: "9",
      name: "James Miller",
      username: "jamesm",
      content: "Makeup and styling preparation",
      imageUrl: ['https://picsum.photos/400/600?random=9'],
      avatarUrl: 'https://i.pravatar.cc/150?img=9',
      likes: 41,
      comments: 11,
      contentType: PostContentType.image,
    ),
    PostModel(
      id: "10",
      name: "Rachel Green",
      username: "rachelg",
      content: "Portfolio review session",
      imageUrl: ['https://picsum.photos/400/600?random=10'],
      avatarUrl: 'https://i.pravatar.cc/150?img=10',
      likes: 33,
      comments: 8,
      contentType: PostContentType.image,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    // fetchPosts();
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
