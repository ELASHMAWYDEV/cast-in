import 'package:cast_in/models/post_model.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:get/get.dart';
import 'package:cast_in/utils/app_assets.dart';

class ViewProfileController extends GetxController {
  bool isLoading = false;
  String name = "Jessica";
  int age = 24;
  String height = "5'6\"";
  String location = "United states of america";
  int followers = 834;
  int following = 162;
  String bio =
      "Embodying elegance and allure, I am the canvas that transforms dreams into reality. Fashion | Beauty | Art | Captivating the lens with every stride. #ModelLife #BeautyInEveryPose";

  List<String> photos = [
    AppAssets.testModelImage1,
    AppAssets.testModelImage2,
    AppAssets.testModelImage3,
    AppAssets.testModelImage4,
    AppAssets.testModelImage5,
    AppAssets.testModelImage6,
  ];
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
  ];

  Future<void> fetchProfile() async {
    isLoading = true;
    update();
    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
    update();
  }
}
