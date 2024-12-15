import 'package:demo_app/services/apple_ml_sound/models/sound_classification_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A service class for interacting with the sound classification capabilities offered by Apple's Sound Analysis
/// framework.
///
/// This class uses Method Channels to communicate with the native Swift code, allowing the Flutter app to perform
/// real-time sound classification or classify sounds from an audio file.
class AppleMLSoundService {
  /// The Method Channel for communicating with the native platform.
  static const MethodChannel _channel = MethodChannel('apple_ml_sound');

  /// The Event Channel for receiving classification results from the native platform.
  static const EventChannel _eventChannel = EventChannel('apple_ml_sound_events');

  /// A stream controller for managing the sound classification results.
  Stream<List<SoundClassificationResult>>? _resultStream;

  /// Starts real-time sound classification using the device's microphone.
  ///
  /// This method initializes audio input on the native side and begins real-time classification. Results are sent back
  /// via a Flutter event listener.
  ///
  /// - Throws: A [PlatformException] if the native side encounters an error.
  Future<void> startSoundClassification() async {
    try {
      await _channel.invokeMethod('startSoundClassification');
    } catch (e) {
      debugPrint('Error starting sound classification: $e');

      rethrow;
    }
  }

  /// Provides a stream of real-time sound classification results.
  ///
  /// Each event from the stream is a list of [SoundClassificationResult] objects, representing
  /// the classification results. Each result contains:
  /// - `identifier`: The name of the detected sound.
  /// - `confidence`: The confidence score of the classification.
  ///
  /// Example:
  /// ```dart
  /// [
  ///   SoundClassificationResult(identifier: 'Dog Barking', confidence: 0.85),
  ///   SoundClassificationResult(identifier: 'Car Horn', confidence: 0.10)
  /// ]
  /// ```
  ///
  /// - Returns: A stream of classification results from the native platform.
  Stream<List<SoundClassificationResult>> get classificationStream {
    if (_resultStream == null) {
      // Initialize the stream by receiving events from the EventChannel
      final Stream<dynamic> eventStream = _eventChannel.receiveBroadcastStream();

      // Map the incoming dynamic data into a list of classification results
      final Stream<List<SoundClassificationResult>> mappedStream = eventStream.map((dynamic data) {
        // Cast the data to a List of dynamic
        final List<dynamic> dataList = data as List<dynamic>;

        // Convert each item in the list into a SoundClassificationResult object
        final List<SoundClassificationResult> results = dataList.map((item) {
          // Ensure each item is a map and convert it to SoundClassificationResult
          final Map<String, dynamic> itemMap = Map<String, dynamic>.from(item as Map<dynamic, dynamic>);
          return SoundClassificationResult.fromMap(itemMap);
        }).toList();

        return results;
      });

      _resultStream = mappedStream;
    }

    return _resultStream!;
  }

  /// Stops real-time sound classification.
  ///
  /// This method stops the audio input and releases any resources used for real-time sound classification.
  ///
  /// - Throws: A [PlatformException] if the native side encounters an error.
  Future<void> stopSoundClassification() async {
    try {
      await _channel.invokeMethod('stopSoundClassification');
    } catch (e) {
      debugPrint('Error stopping sound classification: $e');

      rethrow;
    }
  }

  /// Performs sound classification on an input audio file.
  ///
  /// - [filePath]: The file path of the audio file to classify.
  /// - Returns: A list of [SoundClassificationResult] objects, where each entry contains
  ///   an `identifier` and a `confidence` value.
  ///
  /// Example:
  /// ```dart
  /// [
  ///   SoundClassificationResult(identifier: 'Dog Barking', confidence: 0.85),
  ///   SoundClassificationResult(identifier: 'Car Horn', confidence: 0.10)
  /// ]
  /// ```
  /// - Throws: A [PlatformException] if the native side encounters an error.
  Future<List<SoundClassificationResult>?> classifySoundFile(String filePath) async {
    try {
      // Invoke the Method Channel for sound classification
      final List<dynamic>? results = await _channel.invokeMethod<List<dynamic>>(
        'classifySoundFile',
        {'filePath': filePath},
      );

      // Convert the results into a list of SoundClassificationResult objects
      if (results == null) {
        return null; // Return null if results are not available
      }

      // Step 1: Convert each result to a Map<String, dynamic>
      final List<Map<String, dynamic>> mappedResults = results.map((result) {
        return Map<String, dynamic>.from(result as Map<dynamic, dynamic>);
      }).toList();

      // Step 2: Convert the list of maps into a list of SoundClassificationResult objects
      final List<SoundClassificationResult> classificationResults = mappedResults.map((resultMap) {
        return SoundClassificationResult.fromMap(resultMap);
      }).toList();

      // Step 3: Return the list of SoundClassificationResult objects
      return classificationResults;
    } catch (e) {
      debugPrint('Error classifying sound file: $e');

      rethrow;
    }
  }
}
