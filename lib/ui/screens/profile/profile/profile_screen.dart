import 'package:cast_in/ui/components/main_button.dart';
import 'package:cast_in/ui/components/post/post_card.dart';
import 'package:cast_in/ui/screens/main/main_controller.dart';
import 'package:cast_in/ui/screens/profile/profile/components/profile_and_background_photos.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/app_enums.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final List<PostModel> posts = [
    PostModel(
      name: 'Jackie',
      username: 'Jackie',
      content:
          'Today, we are looking for the perfect model to represent our brand in an upcoming perfume advertisement.',
      avatarUrl: AppAssets.testProfileImage,
      likes: 24,
      comments: 15,
      contentType: PostContentType.text,
    ),
    PostModel(
      name: 'Jackie',
      username: 'Jackie',
      content:
          'Today, we are looking for the perfect model to represent our brand in an upcoming perfume advertisement.',
      avatarUrl: AppAssets.testProfileImage,
      likes: 24,
      comments: 15,
      contentType: PostContentType.text,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            /////// profile photo and background photo
            ProfileAndBackgroundPhotos(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /////// name , followers and following v
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Peter Parker, 24",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyle.headingTextStyle3,
                            ),
                            SizedBox(height: 7),
                            Text(
                              "Photographer",
                              style: AppStyle.bodyTextStyle3,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "834",
                              style: AppStyle.headingTextStyle3,
                            ),
                            SizedBox(height: 7),
                            Text(
                              "Followers",
                              style: AppStyle.bodyTextStyle3,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "162",
                              style: AppStyle.headingTextStyle3,
                            ),
                            SizedBox(height: 7),
                            Text(
                              "Following",
                              style: AppStyle.bodyTextStyle3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ///////location
                  Row(
                    children: [
                      Image.asset(AppAssets.location),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "United states of america",
                        style: AppStyle.bodyTextStyle3,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //// bio
                  Text(
                    "Hey, I'm using Cast In App!",
                    style: AppStyle.bodyTextStyle3.copyWith(color: AppStyle.grey),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  ///////// Adds and post texts
                  Row(
                    children: [
                      Text(
                        "Adds",
                        style: AppStyle.subTitleStyle1.copyWith(fontSize: 20),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.find<MainController>().goToScreen(MainRouter.ADDNEWPOST);
                        },
                        child: Text(
                          "Add Post",
                          style: AppStyle.textButtonTextStyle.copyWith(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: List.generate(
                      posts.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(bottom: index < posts.length - 1 ? 15 : 0),
                        child: PostCard(post: posts[index], isBox: true),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MainButton(
                    onPressed: () {
                      Get.find<MainController>().goToScreen(MainRouter.EDITPROFILE);
                    },
                    title: 'Edit Profile',
                    fullWidth: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
