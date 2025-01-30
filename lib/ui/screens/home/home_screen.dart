import 'package:cast_in/ui/components/post/post_card.dart';
import 'package:cast_in/ui/screens/home/home_controller.dart';
import 'package:cast_in/ui/screens/main/main_controller.dart';
import 'package:cast_in/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: controller.posts.isEmpty
            ? SizedBox(
                height: MediaQuery.of(context).size.height - 100,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.post_add_outlined,
                        size: 64,
                        color: AppStyle.grey.withAlpha(50),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No posts yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppStyle.grey.withAlpha(50),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Skeletonizer(
                enabled: controller.isLoading,
                child: ListView.separated(
                  shrinkWrap: true,
                  controller: Get.find<MainController>().scrollController,
                  itemCount: controller.posts.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 25),
                  itemBuilder: (context, index) => InkWell(
                    child: PostCard(
                      isOpenModalEnabled: false,
                      post: controller.posts[index],
                    ),
                  ),
                ),
              ),
      );
    });
  }
}
