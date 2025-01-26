import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageController extends GetxController {
  final Rx<Size?> imageSize = Rx<Size?>(null);
  final Rx<Size?> matchingRatio = Rx<Size?>(null);

  Future<void> loadImageAndCalculateRatio(String imagePath) async {
    try {
      final size = await _getImageSize(imagePath);
      imageSize.value = size;
      matchingRatio.value = _getMatchingRatio(size);
    } catch (e) {
      print("Error loading image: $e");
    }
  }

  Future<Size> _getImageSize(String imagePath) async {
    final image = AssetImage(imagePath);
    final config = await image.obtainKey(ImageConfiguration.empty);
    final info = await config.bundle.load(config.name);
    final imageFile = await decodeImageFromList(info.buffer.asUint8List());
    return Size(imageFile.width.toDouble(), imageFile.height.toDouble());
  }

  Size _getMatchingRatio(Size originalSize) {
    const ratios = [
      Size(1, 1), // Square
      Size(4, 5), // Portrait
      Size(16, 9) // Landscape
    ];

    double originalRatio = originalSize.width / originalSize.height;

    return ratios.reduce((bestMatch, current) {
      double bestDiff = (bestMatch.width / bestMatch.height - originalRatio).abs();
      double currentDiff = (current.width / current.height - originalRatio).abs();
      return currentDiff < bestDiff ? current : bestMatch;
    });
  }
}
