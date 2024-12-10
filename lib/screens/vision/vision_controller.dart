import 'package:demo_app/screens/vision/vision_route.dart';
import 'package:demo_app/screens/vision/vision_view.dart';
import 'package:demo_app/services/apple_intelligence_vision/apple_intelligence_vision_service.dart';
import 'package:demo_app/services/apple_intelligence_vision/models/apple_intelligence_vision_capability.dart';
import 'package:demo_app/services/apple_intelligence_vision/models/face_detection_result.dart';
import 'package:demo_app/services/apple_intelligence_vision/models/image_classification_result.dart';
import 'package:demo_app/services/apple_intelligence_vision/models/object_detection_result.dart';
import 'package:demo_app/services/apple_intelligence_vision/models/text_recognition_result.dart';
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

  /// The example image selected by the user for text recognition.
  VisionExampleImage? selectedTextRecognitionExampleImage;

  /// The example image selected by the user for face detection.
  VisionExampleImage? selectedFaceDetectionExampleImage;

  /// A list of objects representing the result of the image classification result.
  ///
  /// This value is set when the user requests classification of an image. Each item in this list is an instance of
  /// [ImageClassificationResult] containing the label and confidence score for the classification.
  List<ImageClassificationResult>? imageClassificationResult;

  /// A list of objects representing the result of the object detection result.
  ///
  /// This value is set when the user requests object detection of an image. Each item in this list is an instance of
  /// [ObjectDetectionResult] containing an identifier for the result and the bounding box for the detected object.
  List<ObjectDetectionResult>? objectDetectionResult;

  /// The [VisionExampleImage] corresponding to the [objectDetectionResult] result. This allows tracking of the image for
  /// which object detection was most recently perform, separately from the selected image, which may change as the user
  /// selects different example images.
  VisionExampleImage? objectDetectionImage;

  /// The result of text recognition for the selected image. This value is set when the user requests text recognition.
  /// Each item in this list is an instance of [TextRecognitionResult] containing the recognized text.
  List<TextRecognitionResult>? textRecognitionResult;

  /// The [VisionExampleImage] corresponding to the [faceDetectionResult] result. This allows tracking of the image for
  /// which face detection was most recently perform, separately from the selected image, which may change as the user
  /// selects different example images.
  VisionExampleImage? faceDetectionImage;

  /// The result of face detection for the selected image. This value is set when the user requests face detection.
  /// Each item in this list is an instance of [FaceDetectionResult] containing the bounding box for the detected face.
  List<FaceDetectionResult>? faceDetectionResult;

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
      } else if (service == AppleIntelligenceVisionCapability.textRecognition) {
        selectedTextRecognitionExampleImage = image;
      } else if (service == AppleIntelligenceVisionCapability.faceDetection) {
        selectedFaceDetectionExampleImage = image;
      }
    });
  }

  /// Handles the process of classifying a user-selected image.
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
      imageClassificationResult = classification;
    });
  }

  /// Handles the process of detecting objects in a user-selected image.
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
      objectDetectionResult = detection;
    });
  }

  /// Handles the process of recognizing text in a user-selected image.
  Future<void> onRecognizeText() async {
    if (selectedTextRecognitionExampleImage == null) {
      debugPrint('No example image selected');

      return;
    }

    debugPrint('Performing text recognition');

    // Get the absolute file path of the selected example image
    final String imagePath = await selectedTextRecognitionExampleImage!.getAbsolutePath();

    // Use the natural language service to identify the language of the text.
    final List<TextRecognitionResult>? result = await _visionService.recognizeText(imagePath);

    debugPrint('Recognized text as "$result"');

    setState(() {
      textRecognitionResult = result;
    });
  }

  /// Handles the process of detecting faces in a user-selected image.
  Future<void> onDetectFaces() async {
    if (selectedFaceDetectionExampleImage == null) {
      debugPrint('No example image selected');

      return;
    } else {
      // Store the image for which face detection is being performed
      faceDetectionImage = selectedFaceDetectionExampleImage;
    }

    debugPrint('Performing face detection');

    // Get the absolute file path of the selected example image
    final String imagePath = await selectedFaceDetectionExampleImage!.getAbsolutePath();

    // Use the natural language service to identify the language of the text.
    final List<FaceDetectionResult>? result = await _visionService.detectFaces(imagePath);

    debugPrint('Detected faces as "$result"');

    setState(() {
      faceDetectionResult = result;
    });
  }

  /// Returns a "pretty print" version of the image classification result for display in the UI.
  ///
  /// The [onClassifyImage] function stores the classification result in the [imageClassificationResult] state variable.
  /// This function converts the classification result into a human-readable format for display in the UI, excluding
  /// any results with a confidence score of 0.0.
  String? get prettyPrintImageClassification {
    if (imageClassificationResult == null) {
      return null;
    }

    // Filter results with confidence > 0.01
    final Iterable<ImageClassificationResult> filteredResults =
        imageClassificationResult!.where((ImageClassificationResult result) => result.confidence > 0.01);

    // Convert the results to a human-readable string
    final String prettyPrint = filteredResults
        .map((ImageClassificationResult result) => '${result.identifier} (${result.confidence.toStringAsFixed(2)})')
        .join(',\n');

    return prettyPrint;
  }

  /// Returns a "pretty print" version of the object detection result for display in the UI.
  ///
  /// The [onDetectObjects] function stores the object detection result in the [objectDetectionResult] state variable.
  /// This function converts the object detection result into a human-readable format for display in the UI.
  String? get prettyPrintObjectDetection {
    if (objectDetectionResult == null) {
      return null;
    }

    // Convert the results to a human-readable string
    final String prettyPrint = objectDetectionResult!
        .map((ObjectDetectionResult result) => '${result.identifier} (${result.boundingBox})')
        .join(',\n');

    return prettyPrint;
  }

  /// Returns the "pretty print" version of the text recognition result for display in the UI.
  ///
  /// The [onRecognizeText] function stores the text recognition result in the [textRecognitionResult] state variable.
  /// This function converts the text recognition result into a human-readable format for display in the UI.
  String? get prettyPrintTextRecognition {
    if (textRecognitionResult == null) {
      return null;
    }

    // Convert the results to a human-readable string. Only the highest confidence results will be included.
    final String prettyPrint = textRecognitionResult!.map((TextRecognitionResult result) => result.text).join(',\n');

    return prettyPrint;
  }

  /// Returns the "pretty print" version of the face detection result for display in the UI.
  ///
  /// The [onDetectFaces] function stores the face detection result in the [faceDetectionResult] state variable.
  /// This function converts the face detection result into a human-readable format for display in the UI.
  String? get prettyPrintFaceDetection {
    if (faceDetectionResult == null) {
      return null;
    }

    // Convert the results to a human-readable string.
    final String prettyPrint =
        faceDetectionResult!.map((FaceDetectionResult result) => result.boundingBox.toString()).join(',\n');

    return prettyPrint;
  }

  @override
  Widget build(BuildContext context) => VisionView(this);
}
