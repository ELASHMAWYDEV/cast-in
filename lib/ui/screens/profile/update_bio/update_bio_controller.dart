import 'dart:io';
import 'package:cast_in/ui/screens/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class UpdateBioController extends GetxController {
  final TextEditingController bioController = TextEditingController();
  final Rx<File?> selectedVideo = Rx<File?>(null);
  Rx<VideoPlayerController?> videoPlayerController = Rx<VideoPlayerController?>(null);
  RxBool isVideoInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Set initial bio value
    bioController.text = "Hey, I'm using Cast In App!"; // Replace with actual bio from user data
  }

  @override
  void onClose() {
    bioController.dispose();
    videoPlayerController.value?.dispose();
    super.onClose();
  }

  Future<void> pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      selectedVideo.value = File(video.path);
      await initializeVideoPlayer();
    }
  }

  Future<void> initializeVideoPlayer() async {
    if (selectedVideo.value != null) {
      // Dispose previous controller if exists
      videoPlayerController.value?.dispose();

      // Create and initialize new controller
      final controller = VideoPlayerController.file(selectedVideo.value!);
      await controller.initialize();
      videoPlayerController.value = controller;
      isVideoInitialized.value = true;
    }
  }

  void toggleVideoPlayback() {
    if (videoPlayerController.value?.value.isPlaying ?? false) {
      videoPlayerController.value?.pause();
    } else {
      videoPlayerController.value?.play();
    }
    update();
  }

  void removeVideo() {
    selectedVideo.value = null;
    videoPlayerController.value?.dispose();
    videoPlayerController.value = null;
    isVideoInitialized.value = false;
    update();
  }

  Future<void> updateBio() async {
    // TODO: Implement bio update logic
    print('Bio: ${bioController.text}');
    print('Video: ${selectedVideo.value?.path}');
    Get.find<MainController>().goToScreen(MainRouter.PROFILE);
  }
}
