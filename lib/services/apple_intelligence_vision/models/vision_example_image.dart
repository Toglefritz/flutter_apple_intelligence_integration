import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// A series of example images to be used for demonstrating the capabilities of the Apple Intelligence Vision
/// services.
enum VisionExampleImage {
  /// An image of an apple.
  apple._('assets/vision_examples/vision_example_apple.png'),

  /// An image of a dog.
  dog._('assets/vision_examples/vision_example_dog.png'),

  /// An image of a chair.
  chair._('assets/vision_examples/vision_example_chair.png');

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
