import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  bool isLoading = true;

  List<PostModel> posts = [
    PostModel(
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
      name: 'Jackie',
      username: 'Jackie',
      content:
          'Today, we are looking for the perfect model to represent our brand in an upcoming perfume advertisement.',
      avatarUrl: AppAssets.testProfileImage,
      likes: 24,
      comments: 15,
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
