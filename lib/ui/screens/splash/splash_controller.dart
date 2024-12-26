import 'dart:async';

import 'package:cast_in/utils/app_router.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // set a timeout
    Future.delayed(Duration(seconds: 2), () => Get.offAllNamed(AppRouter.LOGIN));
  }
}
