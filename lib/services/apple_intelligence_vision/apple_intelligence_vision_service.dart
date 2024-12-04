import 'package:demo_app/services/apple_intelligence_vision/models/image_classification_result.dart';
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
  /// This method uses the Vision framework to identify and locate objects in the image. If a custom Core ML model is
  /// provided, it will be used for object detection.
  ///
  /// - [imagePath]: The file path of the image for object detection.
  Future<List<Map<String, dynamic>>?> detectObjects(String imagePath) async {
    try {
      // If a custom model is provided, use it for object detection.
      if (customModelName != null) {
        return await _channel.invokeMethod('detectObjectsWithCustomModel', {
          'imagePath': imagePath,
          'modelName': customModelName,
        }) as List<Map<String, dynamic>>?;
      }
      // Otherwise, use the default Vision model.
      else {
        return await _channel.invokeMethod('detectObjects', {'imagePath': imagePath}) as List<Map<String, dynamic>>?;
      }
    } catch (e) {
      debugPrint('Object detection failed with error, $e');

      return null;
    }
  }

  /// Performs text recognition on an image.
  ///
  /// This method uses the Vision framework to recognize and extract text from an image.
  ///
  /// - [imagePath]: The file path of the image for text recognition.
  Future<String?> recognizeText(String imagePath) async {
    try {
      return await _channel.invokeMethod('recognizeText', {'imagePath': imagePath});
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
