import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// A series of example images to be used for demonstrating the capabilities of the Apple Intelligence Vision
/// services.
enum VisionExampleImage {
  /// An image of a flower.
  flower._('assets/vision_examples/vision_example_flower.png'),

  /// An image of a dog.
  dog._('assets/vision_examples/vision_example_dog.png'),

  /// An image of a chair.
  chair._('assets/vision_examples/vision_example_chair.png'),

  /// An image of a desk with a variety of objects.
  deskScene._('assets/vision_examples/vision_example_desk_scene.png'),

  /// An image of a natural scene showing a variety of objects.
  natureScene._('assets/vision_examples/vision_example_nature_scene.png'),

  /// An image showing a place setting for a meal, with a variety of objects.
  foodScene._('assets/vision_examples/vision_example_food_scene.png'),

  /// An image of a highway road sign.
  roadSign._('assets/vision_examples/vision_example_road_sign.png'),

  /// An image of a book cover.
  bookCover._('assets/vision_examples/vision_example_book_cover.png'),

  /// An image of a coffee shop menu.
  coffeeMenu._('assets/vision_examples/vision_example_coffee_shop_menu.png');

  /// The file path of the image.
  final String path;

  /// Creates a new instance of [VisionExampleImage].
  const VisionExampleImage._(this.path);

  /// Returns an absolute file path for the image that can be accessed by the native platform.
  ///
  /// This method copies the image from the assets to a temporary directory and returns the path to the copy.
  /// The resulting path can be used to classify the image using the Apple Intelligence Vision service.
  Future<String> getAbsolutePath() async {
    // Get the temporary directory for the app
    final Directory tempDir = await getTemporaryDirectory();

    // Determine the destination path
    final String fileName = path.split('/').last; // Extract the file name
    final String filePath = '${tempDir.path}/$fileName';

    // Copy the asset to the temporary directory if it doesn't already exist
    final File file = File(filePath);
    if (!file.existsSync()) {
      final ByteData byteData = await rootBundle.load(path);
      await file.writeAsBytes(byteData.buffer.asUint8List());
    }

    // Return the absolute file path
    return filePath;
  }
}
