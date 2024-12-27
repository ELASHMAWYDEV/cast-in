import 'package:cast_in/ui/screens/splash/splash_controller.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.splashImage,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
