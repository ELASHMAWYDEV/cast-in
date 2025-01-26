import 'package:cast_in/models/post_model.dart';
import 'package:cast_in/utils/helpers.dart';
import 'package:get/get.dart';

class PostDetailsController extends GetxController {
  PostModel? post;
  @override
  void onInit() {
    super.onInit();
    Helpers.appDebugger(Get.arguments as PostModel);
    post = Get.arguments;
    update();
  }
}
