import 'dart:async';
import 'package:cast_in/models/post_model.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreController extends GetxController {
  bool isLoading = false;
  final PageController pageController = PageController(viewportFraction: 0.8);
  Timer? sliderTimer;

  // Mock data for grid images
  final List<String> gridImages = List.generate(
    6,
    (index) => 'https://picsum.photos/400/400?random=${index + 1}',
  );

  // Mock data for text posts
  final List<PostModel> textPosts = [
    PostModel(
      id: '1',
      name: 'Jackie Chan',
      username: 'jackiechan',
      content:
          'Looking for a charismatic male model aged 25-35 for our upcoming martial arts equipment campaign. Must have experience in action poses and martial arts.',
      likes: 245,
      comments: 89,
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      contentType: PostContentType.text,
    ),
    PostModel(
      id: '2',
      name: 'Victoria Secret',
      username: 'victoriasecret',
      content:
          'Casting call for our Spring 2024 runway show! Seeking female models 5\'9" and above. Previous runway experience required.',
      likes: 1893,
      comments: 432,
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      contentType: PostContentType.text,
    ),
    PostModel(
      id: '3',
      name: 'Nike Sports',
      username: 'nikesports',
      content:
          'Athletes wanted! Seeking fitness models for our new performance wear line. Must be able to demonstrate dynamic movements.',
      likes: 892,
      comments: 156,
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      contentType: PostContentType.text,
    ),
    PostModel(
      id: '4',
      name: 'Vogue Italia',
      username: 'vogueitalia',
      content:
          'Editorial models needed for our September issue. Unique and striking features preferred. Send your portfolio today!',
      likes: 2341,
      comments: 567,
      avatarUrl: 'https://i.pravatar.cc/150?img=4',
      contentType: PostContentType.text,
    ),
    PostModel(
      id: '5',
      name: 'L\'Oreal Paris',
      username: 'lorealparis',
      content:
          'Seeking diverse models of all ages for our new skincare campaign. Natural beauty and confidence are key!',
      likes: 1567,
      comments: 298,
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
      contentType: PostContentType.text,
    ),
  ];

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
