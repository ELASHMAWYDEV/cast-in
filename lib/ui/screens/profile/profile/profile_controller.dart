import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  bool isLoading = true;

  List<PostModel> posts = [
    PostModel(
      id: '1',
      name: 'Jackie',
      username: 'Jackie',
      content:
          'Today, we are looking for the perfect model to represent our brand in an upcoming perfume advertisement.',
      avatarUrl: AppAssets.testProfileImage,
      likes: 24,
      comments: 15,
      contentType: PostContentType.text,
    ),
    PostModel(
      id: '2',
      name: 'Jackie',
      username: 'Jackie',
      content:
          'Today, we are looking for the perfect model to represent our brand in an upcoming perfume advertisement.',
      avatarUrl: AppAssets.testProfileImage,
      likes: 24,
      comments: 15,
      contentType: PostContentType.text,
    ),
    PostModel(
      id: '3',
      name: 'Peter',
      username: 'PeterParker',
      content:
          'Looking for talented photographers to collaborate on an upcoming fashion magazine shoot. Must have experience with studio lighting.',
      avatarUrl: AppAssets.testProfileImage,
      likes: 45,
      comments: 28,
      contentType: PostContentType.text,
    ),
    PostModel(
      id: '4',
      name: 'Sarah',
      username: 'SarahModel',
      content: 'Just wrapped up an amazing photoshoot for summer collection. Can\'t wait to share the results!',
      avatarUrl: AppAssets.testProfileImage,
      likes: 156,
      comments: 42,
      contentType: PostContentType.text,
    ),
    PostModel(
      id: '5',
      name: 'Mike',
      username: 'MikeDirector',
      content: 'Casting call for upcoming TV commercial. Looking for diverse faces, all ages welcome. Send portfolios.',
      avatarUrl: AppAssets.testProfileImage,
      likes: 89,
      comments: 67,
      contentType: PostContentType.text,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    isLoading = true;
    update();

    // Simulate API call delay
    await Future.delayed(Duration(seconds: 2));

    // TODO: Replace with actual API call
    isLoading = false;
    update();
  }
}
