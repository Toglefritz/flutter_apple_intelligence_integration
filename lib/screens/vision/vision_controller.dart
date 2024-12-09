import 'package:demo_app/screens/vision/vision_route.dart';
import 'package:demo_app/screens/vision/vision_view.dart';
import 'package:demo_app/services/apple_intelligence_vision/apple_intelligence_vision_service.dart';
import 'package:demo_app/services/apple_intelligence_vision/models/apple_intelligence_vision_capability.dart';
import 'package:demo_app/services/apple_intelligence_vision/models/image_classification_result.dart';
import 'package:demo_app/services/apple_intelligence_vision/models/object_detection_result.dart';
import 'package:demo_app/services/apple_intelligence_vision/models/vision_example_image.dart';
import 'package:flutter/material.dart';

/// A controller for the [VisionRoute].
class VisionController extends State<VisionRoute> {
  /// A service for using the natural language processing capabilities of Apple Intelligence.
  final AppleIntelligenceVisionService _visionService = AppleIntelligenceVisionService();

  /// The example image selected by the user for classification.
  VisionExampleImage? selectedClassificationExampleImage;

  /// The example image selected by the user for object detection.
  VisionExampleImage? selectedObjectDetectionExampleImage;

  /// A list of objects representing the result of the image classification result.
  ///
  /// This value is set when the user requests classification of an image. Each item in this list is an instance of
  /// [ImageClassificationResult] containing the label and confidence score for the classification.
  List<ImageClassificationResult>? imageClassification;

  /// A list of objects representing the result of the object detection result.
  ///
  /// This value is set when the user requests object detection of an image. Each item in this list is an instance of
  /// [ObjectDetectionResult] containing an identifier for the result and the bounding box for the detected object.
  List<ObjectDetectionResult>? objectDetection;

  /// The [VisionExampleImage] corresponding to the [objectDetection] result. This allows tracking of the image for
  /// which object detection was most recently perform, separately from the selected image, which may change as the user
  /// selects different example images.
  VisionExampleImage? objectDetectionImage;

  /// Called when the back button is tapped.
  void onBack() {
    // Pop the current route off the navigator and go back to the HomeRoute.
    Navigator.of(context).pop();
  }

  /// Called when the user selects an example image for one of the windows providing demonstrations of the vision
  /// capabilities of Apple Intelligence.
  ///
  /// This function updates the state to reflect the selected example image. The provided
  /// [AppleIntelligenceVisionCapability] determines the demonstration for which an image was selected.
  void onSelectExampleImage({
    required VisionExampleImage image,
    required AppleIntelligenceVisionCapability service,
  }) {
    debugPrint('Selected example image: $image');

    setState(() {
      if (service == AppleIntelligenceVisionCapability.classification) {
        selectedClassificationExampleImage = image;
      } else if (service == AppleIntelligenceVisionCapability.objectDetection) {
        selectedObjectDetectionExampleImage = image;
      }
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
    if (selectedClassificationExampleImage == null) {
      debugPrint('No example image selected');

      return;
    }

    debugPrint('Performing image classification');

    // Get the absolute file path of the selected example image
    final String imagePath = await selectedClassificationExampleImage!.getAbsolutePath();

    // Use the natural language service to identify the language of the text.
    final List<ImageClassificationResult>? classification = await _visionService.classifyImage(imagePath);

    debugPrint('Classified image as "${classification?.first.identifier}: ${classification?.first.confidence}"');

    setState(() {
      imageClassification = classification;
    });
  }

  /// Handles the process of detecting objects in a user-selected image.
  // TODO(Scott): Add documentation
  Future<void> onDetectObjects() async {
    if (selectedObjectDetectionExampleImage == null) {
      debugPrint('No example image selected');

      return;
    } else {
      // Store the image for which object detection is being performed
      objectDetectionImage = selectedObjectDetectionExampleImage;
    }

    debugPrint('Performing object detection');

    // Get the absolute file path of the selected example image
    final String imagePath = await selectedObjectDetectionExampleImage!.getAbsolutePath();

    // Use the natural language service to identify the language of the text.
    final List<ObjectDetectionResult>? detection = await _visionService.detectObjects(imagePath);

    debugPrint('Detected objects as "$detection"');

    setState(() {
      objectDetection = detection;
    });
  }

  /// Returns a "pretty print" version of the image classification result for display in the UI.
  ///
  /// The [onClassifyImage] function stores the classification result in the [imageClassification] state variable.
  /// This function converts the classification result into a human-readable format for display in the UI, excluding
  /// any results with a confidence score of 0.0.
  String? get prettyPrintImageClassification {
    if (imageClassification == null) {
      return null;
    }

    // Filter results with confidence > 0.01
    final Iterable<ImageClassificationResult> filteredResults =
        imageClassification!.where((ImageClassificationResult result) => result.confidence > 0.01);

    // Convert the results to a human-readable string
    final String prettyPrint = filteredResults
        .map((ImageClassificationResult result) => '${result.identifier} (${result.confidence.toStringAsFixed(2)})')
        .join(',\n');

    return prettyPrint;
  }

  /// Returns a "pretty print" version of the object detection result for display in the UI.
  ///
  /// The [onDetectObjects] function stores the object detection result in the [objectDetection] state variable.
  /// This function converts the object detection result into a human-readable format for display in the UI.
  String? get prettyPrintObjectDetection {
    if (objectDetection == null) {
      return null;
    }

    // Convert the results to a human-readable string
    final String prettyPrint = objectDetection!
        .map((ObjectDetectionResult result) => '${result.identifier} (${result.boundingBox})')
        .join(',\n');

    return prettyPrint;
  }

  @override
  Widget build(BuildContext context) => VisionView(this);
}
