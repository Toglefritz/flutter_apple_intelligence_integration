import 'package:demo_app/services/apple_intelligence_vision/models/image_classification_result.dart';
import 'package:demo_app/services/apple_intelligence_vision/models/object_detection_result.dart';
import 'package:demo_app/services/apple_intelligence_vision/models/text_recognition_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A service class for interacting with the Apple Intelligence Vision ML services.
///
/// This class provides an interface for performing various vision-related tasks, such as image classification and
/// object detection, using Apple's Vision framework. Developers can instantiate this service with or without a custom
/// Core ML model, allowing for both general-purpose and domain-specific use cases.
///
/// This service acts as the bridge between the Flutter application and the native iOS/macOS Vision framework. It
/// communicates with native code via Method Channels to leverage the advanced machine learning capabilities offered
/// by Apple Intelligence. Developers can choose between using Apple's pre-trained Vision models or providing their own
/// custom Core ML models for specialized tasks.
///
/// ## Usage
///
/// - Use the default constructor to rely on Apple's pre-trained models:
///
/// ```dart
/// final AppleIntelligenceVisionService visionService = AppleIntelligenceVisionService();
/// ```
///
/// - Use the factory constructor to specify a custom Core ML model:
///
/// ```dart
/// final AppleIntelligenceVisionService visionServiceWithCustomModel =
/// AppleIntelligenceVisionService.withCustomModel('CustomVisionModel');
/// ```
class AppleIntelligenceVisionService {
  /// The [MethodChannel] used for communication with the native platform code.
  static const MethodChannel _channel = MethodChannel('apple_intelligence_vision');

  /// The name of the custom Core ML model to use, if provided.
  final String? customModelName;

  /// Default constructor for the service, using the built-in Vision models.
  AppleIntelligenceVisionService() : customModelName = null;

  /// Factory constructor for the service with a custom Core ML model.
  factory AppleIntelligenceVisionService.withCustomModel(String modelName) {
    return AppleIntelligenceVisionService._internal(customModelName: modelName);
  }

  /// Internal constructor for handling initialization with or without a custom model.
  AppleIntelligenceVisionService._internal({this.customModelName});

  /// Classifies an image using the Apple Intelligence Vision services.
  ///
  /// - [imagePath]: The file path of the image to classify.
  /// - Returns: A list of classification results where each result is a map with:
  ///   - `identifier`: The label for the classification.
  ///   - `confidence`: The confidence score as a percentage.
  /// Classifies an image using the Apple Intelligence Vision services.
  ///
  /// - [imagePath]: The file path of the image to classify.
  /// - Returns: A list of [ImageClassificationResult] objects containing the
  ///   label (`identifier`) and confidence score (`confidence`) for each classification.
  Future<List<ImageClassificationResult>?> classifyImage(String imagePath) async {
    try {
      // Prepare arguments for the Method Channel call
      final Map<String, dynamic> arguments = {
        'imagePath': imagePath,
        if (customModelName != null) 'modelName': customModelName,
      };

      // Invoke the Method Channel and cast the result
      final List<dynamic>? result = await _channel.invokeMethod<List<dynamic>>(
        customModelName != null ? 'classifyImageWithCustomModel' : 'classifyImage',
        arguments,
      );

      // Convert the result to a List<ImageClassificationResult>
      final List<ImageClassificationResult>? results = result?.map((item) {
        if (item is Map<Object?, Object?>) {
          // Convert Map<Object?, Object?> to Map<String, dynamic>
          final Map<String, dynamic> convertedMap = item.map(
            (key, value) => MapEntry(key.toString(), value),
          );

          return ImageClassificationResult.fromMap(convertedMap);
        }

        throw Exception('Unexpected item format: $item');
      }).toList();

      return results;
    } catch (e) {
      debugPrint('Image classification failed with error, $e');

      return null;
    }
  }

  /// Detects objects in an image.
  ///
  /// This method uses Apple's Vision framework to perform object detection on the provided image.
  /// It identifies objects within the image and returns their labels along with bounding boxes
  /// representing their locations. If a custom Core ML model is provided during initialization,
  /// it will be used for object detection instead of the default Vision model.
  ///
  /// ## Parameters
  ///
  /// - [imagePath]: The file path of the image on which object detection is performed. The image
  ///   must be accessible from the device at this path.
  ///
  /// ## Returns
  ///
  /// A `Future` that resolves to a list of [ObjectDetectionResult] objects. Each object contains:
  /// - `identifier`: A string label representing the name of the detected object (e.g., "bicycle").
  /// - `boundingBox`: A list of four `double` values representing the normalized bounding box
  ///   coordinates:
  ///   - **`x`**: The horizontal position of the top-left corner of the bounding box, relative to
  ///     the image width.
  ///   - **`y`**: The vertical position of the top-left corner of the bounding box, relative to
  ///     the image height.
  ///   - **`width`**: The width of the bounding box, as a fraction of the image width.
  ///   - **`height`**: The height of the bounding box, as a fraction of the image height.
  ///
  /// ## Coordinate System and Transformation
  ///
  /// Object detection models typically use a coordinate system where the origin (`0,0`) is located
  /// at the **bottom-left** corner of the image. This differs from the coordinate system used by
  /// Flutter widgets, where the origin is at the **top-left** corner. As a result, the `y`
  /// coordinate and the bounding box must be transformed to display correctly in a Flutter widget:
  ///
  /// ```dart
  /// final transformedY = 1.0 - boundingBox[1] - boundingBox[3];
  /// ```
  ///
  /// This transformation ensures that the vertical positioning of the bounding boxes aligns with
  /// the Flutter coordinate system when rendering the image.
  ///
  /// ## Error Handling
  ///
  /// If the object detection process fails (e.g., due to an invalid image path or model errors),
  /// the function logs the error and returns `null`.
  ///
  /// ## Example
  ///
  /// Given an image containing a bicycle and a dining table, the function might return:
  ///
  /// ```json
  /// [
  ///   { "identifier": "bicycle", "boundingBox": [0.52, 0.13, 0.42, 0.37] },
  ///   { "identifier": "diningtable", "boundingBox": [0.04, 0.18, 0.41, 0.20] }
  /// ]
  /// ```
  ///
  /// These results can be visualized by overlaying the bounding boxes on the image in a Flutter
  /// widget, with the necessary coordinate transformations for the `y` axis.
  Future<List<ObjectDetectionResult>?> detectObjects(String imagePath) async {
    try {
      // Prepare arguments for the Method Channel call
      final Map<String, dynamic> arguments = {
        'imagePath': imagePath,
        if (customModelName != null) 'modelName': customModelName,
      };

      // Invoke the Method Channel and cast the result
      final List<dynamic>? result = await _channel.invokeMethod<List<dynamic>>(
        customModelName != null ? 'detectObjectsWithCustomModel' : 'detectObjects',
        arguments,
      );

      // Convert the result to a List<ObjectDetectionResult>
      final List<ObjectDetectionResult>? results = result?.map((item) {
        if (item is Map<Object?, Object?>) {
          // Convert Map<Object?, Object?> to Map<String, dynamic>
          final Map<String, dynamic> convertedMap = item.map(
            (key, value) => MapEntry(key.toString(), value),
          );

          return ObjectDetectionResult.fromMap(convertedMap);
        }

        throw Exception('Unexpected item format: $item');
      }).toList();

      // Return the list of ObjectDetectionResult objects
      return results;
    } catch (e) {
      debugPrint('Object detection failed with error, $e');

      return null;
    }
  }

  /// Performs text recognition on an image.
  ///
  /// This method uses the Vision framework to recognize text in the provided image. It communicates
  /// with the native platform (iOS) via a Method Channel and returns the full set of text recognition
  /// results, including all recognition candidates for each text region and their bounding boxes.
  ///
  /// ## Parameters
  /// - [imagePath]: The file path of the image for text recognition. The image must be accessible
  ///   at the specified path.
  ///
  /// ## Returns
  /// A `Future` that resolves to a list of `TextRecognitionResult` objects, where each object represents:
  /// - `text`: The most confident recognized text for the region.
  /// - `candidates`: A list of all recognition candidates for the region, ordered by confidence.
  /// - `boundingBox`: The bounding box of the text region as a list of four normalized values:
  ///   - **`x`**: The horizontal position of the bottom-left corner of the bounding box, relative to the image width.
  ///   - **`y`**: The vertical position of the bottom-left corner of the bounding box, relative to the image height.
  ///   - **`width`**: The width of the bounding box, as a fraction of the image width.
  ///   - **`height`**: The height of the bounding box, as a fraction of the image height.
  ///
  /// ## Example Return Value
  /// If the image contains a road sign with the text:
  ///
  /// ```text
  /// EXIT 25
  /// Downtown 3 Miles
  /// ```
  ///
  /// The method might return:
  ///
  /// ```dart
  /// [
  ///   TextRecognitionResult(
  ///     text: 'EXIT 25',
  ///     candidates: ['EXIT 25', 'EXT 25', 'EXIT2 5'],
  ///     boundingBox: [0.1, 0.6, 0.8, 0.2],
  ///   ),
  ///   TextRecognitionResult(
  ///     text: 'Downtown 3 Miles',
  ///     candidates: ['Downtown 3 Miles', 'Downtown 3Mile', 'Downtown 3Miles'],
  ///     boundingBox: [0.1, 0.4, 0.8, 0.2],
  ///   ),
  /// ]
  /// ```
  ///
  /// ## Error Handling
  /// If the text recognition process fails (e.g., due to an invalid image path), the function logs the
  /// error and returns `null`.
  Future<List<TextRecognitionResult>?> recognizeText(String imagePath) async {
    try {
      // Call the Method Channel
      final List<dynamic>? result = await _channel.invokeMethod<List<dynamic>>(
        'recognizeText',
        {'imagePath': imagePath},
      );

      // Parse the result into a list of TextRecognitionResult objects
      final List<TextRecognitionResult>? results = result?.map((item) {
        if (item is Map<Object?, Object?>) {
          // Convert Map<Object?, Object?> to Map<String, dynamic>
          final Map<String, dynamic> convertedMap = item.map(
            (key, value) => MapEntry(key.toString(), value),
          );
          return TextRecognitionResult.fromMap(convertedMap);
        }

        throw Exception('Unexpected item format: $item');
      }).toList();

      return results;
    } catch (e) {
      debugPrint('Text recognition failed with error, $e');
      return null;
    }
  }

  /// Detects faces in an image.
  ///
  /// This method uses the Vision framework to identify faces in an image and provides their locations and bounding
  /// boxes.
  ///
  /// - [imagePath]: The file path of the image for face detection.
  Future<List<Map<String, dynamic>>?> detectFaces(String imagePath) async {
    try {
      return await _channel.invokeMethod('detectFaces', {'imagePath': imagePath}) as List<Map<String, dynamic>>?;
    } catch (e) {
      debugPrint('Face detection failed with exception, $e');

      return null;
    }
  }
}
