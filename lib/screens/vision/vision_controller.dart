import 'package:demo_app/screens/vision/vision_route.dart';
import 'package:demo_app/screens/vision/vision_view.dart';
import 'package:demo_app/services/apple_intelligence_vision/apple_intelligence_vision_service.dart';
import 'package:demo_app/services/apple_intelligence_vision/models/vision_example_image.dart';
import 'package:flutter/material.dart';

/// A controller for the [VisionRoute].
class VisionController extends State<VisionRoute> {
  /// A service for using the natural language processing capabilities of Apple Intelligence.
  final AppleIntelligenceVisionService _visionService = AppleIntelligenceVisionService();

  /// The example image selected by the user for classification.
  VisionExampleImage? selectedExampleImage;

  /// A string representation of the image classification result.
  ///
  /// This value is set when the user requests classification of an image.
  String? imageClassification;

  /// Called when the back button is tapped.
  void onBack() {
    // Pop the current route off the navigator and go back to the HomeRoute.
    Navigator.of(context).pop();
  }

  /// Called when the user selects an example image for classification.
  void onSelectExampleImage(VisionExampleImage image) {
    debugPrint('Selected example image: $image');

    setState(() {
      selectedExampleImage = image;
    });
  }

  /// Handles the process of classifying a user-selected image.
  ///
  /// ### Overview
  /// This function is triggered when the user submits an image for classification. It ensures that an image is
  /// selected, retrieves the absolute file path of the image, and uses the Vision service to classify the image into
  /// a specific category. The classification result is displayed and stored in the application's state for further use.
  ///
  /// ### Workflow
  /// 1. Checks if an example image is selected. If not, it logs a message and terminates the process.
  /// 2. Retrieves the absolute file path of the selected image using the `getAbsolutePath` method.
  /// 3. Calls the Vision service to classify the image based on its contents.
  /// 4. Logs the classification result and updates the state to store the classification.
  ///
  /// ### Example Use Case
  /// This function is designed for applications where users can select an example image (e.g., an image of a dog or an
  /// apple) and submit it for classification. The classification result could be displayed to the user or used for
  /// further processing.
  ///
  /// ### Parameters
  /// - This function does not accept parameters directly but relies on:
  ///   - The `selectedExampleImage` to determine which image to classify.
  ///   - The `_visionService` to perform the actual image classification.
  ///
  /// ### Behavior
  /// - If no image is selected, the function logs a message and returns early.
  /// - If an image is successfully classified, the classification result (e.g., "Dog") is stored in
  ///   the `imageClassification` state variable and can be used by the UI.
  Future<void> onClassifyImage() async {
    if (selectedExampleImage == null) {
      debugPrint('No example image selected');

      return;
    }

    debugPrint('Performing image classification');

    // Get the absolute file path of the selected example image
    final String imagePath = await selectedExampleImage!.getAbsolutePath();

    // Use the natural language service to identify the language of the text.
    final String? classification = await _visionService.classifyImage(imagePath);

    debugPrint('Classified image as "$classification"');

    setState(() {
      imageClassification = classification;
    });
  }

  @override
  Widget build(BuildContext context) => VisionView(this);
}
