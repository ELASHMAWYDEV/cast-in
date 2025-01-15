import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreController extends GetxController {
  bool isLoading = false;
  final PageController pageController = PageController(viewportFraction: 0.8);
  Timer? sliderTimer;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
    startSliderAutoScroll();
  }

  Future<void> fetchPosts() async {
    isLoading = true;
    update();
    await Future.delayed(const Duration(seconds: 3));
    isLoading = false;
    update();
  }

  void startSliderAutoScroll() {
    sliderTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (pageController.hasClients) {
        int nextPage = (pageController.page?.round() ?? 0) + 1;
        pageController.animateToPage(
          nextPage % 6,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void onClose() {
    sliderTimer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}
