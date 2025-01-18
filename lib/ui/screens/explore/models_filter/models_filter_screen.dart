import 'package:cast_in/ui/screens/explore/models_filter/models_filter_controller.dart';
import 'package:cast_in/ui/screens/main/main_controller.dart';
import 'package:cast_in/utils/app_assets.dart';
import 'package:cast_in/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ModelsFilterScreen extends StatelessWidget {
  ModelsFilterScreen({super.key});

  final ModelsFilterController controller = Get.put(ModelsFilterController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ModelsFilterController>(builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Skeletonizer(
          enabled: controller.isLoading,
          child: ListView.builder(
            shrinkWrap: true,
            controller: Get.find<MainController>().scrollController,
            itemCount: controller.models.length,
            itemBuilder: (context, index) {
              final model = controller.models[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(AppAssets.testProfileImage),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Age: ',
                                      style: AppStyle.bodyTextStyle2.copyWith(color: AppStyle.grey, fontSize: 12),
                                    ),
                                    TextSpan(
                                      text: '${model['age']}',
                                      style: AppStyle.bodyTextStyle2
                                          .copyWith(color: AppStyle.primaryTextColor, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Height: ',
                                      style: AppStyle.bodyTextStyle2.copyWith(color: AppStyle.grey, fontSize: 12),
                                    ),
                                    TextSpan(
                                      text: '${model['height']}',
                                      style: AppStyle.bodyTextStyle2
                                          .copyWith(color: AppStyle.primaryTextColor, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'City: ',
                                      style: AppStyle.bodyTextStyle2.copyWith(color: AppStyle.grey, fontSize: 12),
                                    ),
                                    TextSpan(
                                      text: '${model['city']}',
                                      style: AppStyle.bodyTextStyle2
                                          .copyWith(color: AppStyle.primaryTextColor, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            model['name'],
                            style: AppStyle.bodyTextStyle1,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => controller.followModel(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStyle.secondaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Follow'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
