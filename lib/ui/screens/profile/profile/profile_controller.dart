import 'package:cast_in/models/post_model.dart';
import 'package:cast_in/models/user_model.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
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

      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock user profile
      userProfile = UserModel(
        id: '1',
        fullName: 'John Doe',
        username: 'johndoe',
        email: 'john@example.com',
        phoneNumber: '+1234567890',
        country: 'United States',
        city: 'New York',
        age: 28,
        profession: 'Professional Model',
        bio: 'Passionate about modeling and photography. Available for photoshoots!',
        userType: UserType.model,
        profileImageUrl: 'https://i.pravatar.cc/300',
        coverImageUrl: 'https://picsum.photos/800/400',
      );

      // Mock followers and following counts
      followersCount = 1234;
      followingCount = 567;

      // Mock posts
      posts = [
        PostModel(
          id: '1',
          name: 'John Doe',
          username: 'johndoe',
          content: 'Recent photoshoot in downtown NYC',
          imageUrl: ['https://picsum.photos/400/600'],
          avatarUrl: 'https://i.pravatar.cc/150',
          likes: 156,
          comments: 23,
          contentType: PostContentType.image,
        ),
        PostModel(
          id: '2',
          name: 'John Doe',
          username: 'johndoe',
          content: 'Behind the scenes from yesterday\'s fashion show',
          imageUrl: ['https://picsum.photos/400/601'],
          avatarUrl: 'https://i.pravatar.cc/150',
          likes: 289,
          comments: 45,
          contentType: PostContentType.image,
        ),
        PostModel(
          id: '3',
          name: 'John Doe',
          username: 'johndoe',
          content: 'Summer collection photoshoot at the beach',
          imageUrl: ['https://picsum.photos/400/602'],
          avatarUrl: 'https://i.pravatar.cc/150',
          likes: 342,
          comments: 67,
          contentType: PostContentType.image,
        ),
        PostModel(
          id: '4',
          name: 'John Doe',
          username: 'johndoe',
          content: 'Studio session for upcoming magazine cover',
          imageUrl: ['https://picsum.photos/400/603'],
          avatarUrl: 'https://i.pravatar.cc/150',
          likes: 421,
          comments: 89,
          contentType: PostContentType.image,
        ),
        PostModel(
          id: '5',
          name: 'John Doe',
          username: 'johndoe',
          content: 'Fashion week highlights',
          imageUrl: ['https://picsum.photos/400/604'],
          avatarUrl: 'https://i.pravatar.cc/150',
          likes: 567,
          comments: 112,
          contentType: PostContentType.image,
        )
      ];
    } catch (e) {
      // Handle error appropriately
    } finally {
      isLoading = false;
      update();
    }
  }
}
