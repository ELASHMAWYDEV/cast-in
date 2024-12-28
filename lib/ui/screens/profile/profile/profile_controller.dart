import 'package:get/get.dart';
import 'package:cast_in/utils/app_assets.dart';

class ProfileController extends GetxController {
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

  Future<void> fetchProfile() async {
    isLoading = true;
    update();
    await Future.delayed(const Duration(seconds: 1));
    isLoading = false;
    update();
  }
}
