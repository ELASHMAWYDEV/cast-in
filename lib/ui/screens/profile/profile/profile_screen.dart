import 'package:cast_in/ui/screens/main_layout/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () => Get.find<MainController>().goToScreen(MainRouter.SETTINGS),
          child: Text("Profile screen not ready yet")),
    );
  }
}
