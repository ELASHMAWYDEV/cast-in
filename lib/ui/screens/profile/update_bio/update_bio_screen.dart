import 'package:cast_in/ui/components/main_button.dart';
import 'package:cast_in/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'update_bio_controller.dart';

class UpdateBioScreen extends StatelessWidget {
  UpdateBioScreen({super.key});

  final UpdateBioController controller = Get.put(UpdateBioController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height - 220,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBioInput(),
            const SizedBox(height: 45),
            _buildVideoSection(),
            const Spacer(),
            _buildUpdateButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBioInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bio',
          style: AppStyle.headingTextStyle1.copyWith(
            fontSize: 15,
            color: AppStyle.minBlack,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppStyle.grey.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller.bioController,
            maxLines: 4,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              hintText: 'Write something about yourself...',
            ),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Introduction Video (Optional)',
          style: AppStyle.headingTextStyle1.copyWith(
            fontSize: 15,
            color: AppStyle.minBlack,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 265,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppStyle.grey.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Obx(() {
            if (controller.selectedVideo.value == null) {
              return Center(
                child: IconButton(
                  icon: const Icon(Icons.video_library_outlined, size: 40),
                  color: AppStyle.minBlack,
                  onPressed: controller.pickVideo,
                ),
              );
            }

            return Stack(
              children: [
                if (controller.isVideoInitialized.value)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: controller.videoPlayerController.value!.value.aspectRatio,
                      child: VideoPlayer(controller.videoPlayerController.value!),
                    ),
                  ),
                Positioned.fill(
                  child: GestureDetector(
                    onTap: controller.toggleVideoPlayback,
                    child: Container(
                      color: Colors.transparent,
                      child: Center(
                        child: Icon(
                          controller.videoPlayerController.value?.value.isPlaying ?? false
                              ? Icons.pause_circle_outline
                              : Icons.play_circle_outline,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(50),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: const EdgeInsets.all(4),
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.white,
                      ),
                      onPressed: controller.removeVideo,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildUpdateButton() {
    return MainButton(
      onPressed: controller.updateBio,
      title: 'Update Bio',
      fullWidth: true,
    );
  }
}
