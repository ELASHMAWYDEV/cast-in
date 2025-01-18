import 'package:cast_in/ui/screens/explore/explore/explore_controller.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:cast_in/utils/style.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/ui/components/post/post_card.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'dart:async';
import 'package:cast_in/utils/app_router.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> with SingleTickerProviderStateMixin {
  final ExploreController controller = Get.put(ExploreController());
  late final AnimationController _animationController;
  late final Animation<Offset> _animation;
  final ScrollController _scrollController = ScrollController();
  final int numberOfGrids = 3;
  Timer? _scrollPauseTimer;
  bool _userScrolling = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat();

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(-1 / numberOfGrids, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));

    // Add scroll listener for infinite loop
    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;

      final maxScroll = _scrollController.position.maxScrollExtent;
      final minScroll = _scrollController.position.minScrollExtent;
      final currentScroll = _scrollController.position.pixels;

      if (currentScroll >= maxScroll) {
        // When reaching the end, jump to one-third of the scroll
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.jumpTo(minScroll + (maxScroll - minScroll) / 3);
        });
      } else if (currentScroll <= minScroll) {
        // When reaching the start, jump to two-thirds of the scroll
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.jumpTo(minScroll + 2 * (maxScroll - minScroll) / 3);
        });
      }
    });
  }

  void _handleUserScrollStart(PointerDownEvent event) {
    _userScrolling = true;
    _animationController.stop();
    _scrollPauseTimer?.cancel();
  }

  void _handleUserScrollEnd(PointerUpEvent event) {
    _userScrolling = false;
    _scrollPauseTimer = Timer(Duration(seconds: 3), () {
      if (!_userScrolling) {
        _animationController.forward();
        _animationController.repeat();
      }
    });
  }

  @override
  void dispose() {
    _scrollPauseTimer?.cancel();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExploreController>(builder: (_) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    filled: true,
                    fillColor: AppStyle.secondaryBgColor,
                    hintStyle: AppStyle.bodyTextStyle2.copyWith(color: AppStyle.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {},
                        iconSize: 24,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Models Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Models',
                  style: AppStyle.headingTextStyle2,
                ),
              ),
              const SizedBox(height: 16),
              Skeletonizer(
                enabled: controller.isLoading,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Listener(
                    onPointerDown: _handleUserScrollStart,
                    onPointerUp: _handleUserScrollEnd,
                    child: SlideTransition(
                      position: _animation,
                      child: Row(
                        children: List.generate(numberOfGrids, (index) => _buildGridSection()),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Adds Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Adds',
                  style: AppStyle.headingTextStyle2,
                ),
              ),
              const SizedBox(height: 16),
              Skeletonizer(
                enabled: controller.isLoading,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) => Column(
                    children: [
                      PostCard(
                        post: PostModel(
                          id: '1',
                          name: 'Jackie',
                          username: 'Jackie',
                          content:
                              'Today, we are looking for the perfect model to represent our brand in an upcoming perfume advertisement.',
                          likes: 24,
                          comments: 15,
                          avatarUrl: AppAssets.testProfileImage,
                          contentType: PostContentType.text,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildGridSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          final images = [
            AppAssets.testModelImage1,
            AppAssets.testModelImage2,
            AppAssets.testModelImage3,
            AppAssets.testModelImage4,
            AppAssets.testModelImage5,
            AppAssets.testModelImage6,
          ];
          return GestureDetector(
            onTap: () {
              // Stop animation when navigating
              _animationController.stop();
              Get.toNamed(
                AppRouter.VIEW_PROFILE,
                arguments: {'userId': 'user_$index'}, // Replace with actual user IDs
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
