import 'dart:async';
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
      // Set a default ratio if image loading fails
      matchingRatio.value = const Size(1, 1);
    }
  }

  Future<Size> _getImageSize(String imagePath) async {
    final completer = Completer<Size>();
    final image = NetworkImage(imagePath);

    final listener = ImageStreamListener(
      (ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      },
      onError: (dynamic exception, StackTrace? stackTrace) {
        completer.completeError(exception);
      },
    );

    final stream = image.resolve(ImageConfiguration.empty);
    stream.addListener(listener);

    return completer.future;
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
