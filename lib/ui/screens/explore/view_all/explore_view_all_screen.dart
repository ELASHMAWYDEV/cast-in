import 'package:cast_in/ui/common/custom_appbar.dart';
import 'package:cast_in/ui/components/post/post_card.dart';
import 'package:cast_in/ui/screens/explore/view_all/explore_view_all_controller.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExploreViewAllScreen extends StatelessWidget {
  final bool showPhotoPosts;

  ExploreViewAllScreen({
    super.key,
    required this.showPhotoPosts,
  });

  final controller = Get.put(ExploreViewAllController());
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ExploreViewAllController>(
        builder: (_) => CustomScrollView(controller: scrollController, slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 60,
            backgroundColor: Colors.transparent,
            floating: true,
            pinned: false,
            automaticallyImplyLeading: false,
            centerTitle: true,
            flexibleSpace: CustomAppBar(
              title: showPhotoPosts ? 'Models' : 'Adds',
              isBackBtnEnabled: true,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height + 100,
              child: Skeletonizer(
                enabled: controller.isLoading,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: 10, // Replace with actual post count
                  separatorBuilder: (context, index) => const SizedBox(height: 30),
                  itemBuilder: (context, index) {
                    // Temporary mock data - replace with actual data from API
                    final post = PostModel(
                      id: index.toString(),
                      name: showPhotoPosts ? 'Model Name' : 'Company Name',
                      username: 'username$index',
                      content: showPhotoPosts
                          ? 'Professional model portfolio showcase'
                          : 'Looking for models for our upcoming campaign',
                      likes: 100 + index,
                      comments: 50 + index,
                      avatarUrl: showPhotoPosts ? AppAssets.testModelImage1 : AppAssets.testProfileImage,
                      contentType: showPhotoPosts ? PostContentType.image : PostContentType.text,
                      imageUrl: showPhotoPosts ? [AppAssets.testModelImage1] : null,
                    );

                    return PostCard(post: post, isOpenModalEnabled: false);
                  },
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
