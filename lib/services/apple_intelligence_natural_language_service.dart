import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A service class for interacting with the Apple Intelligence Natural Language (NLP) services.
///
/// This class provides an interface for performing various natural language processing tasks, such as language
/// identification, sentiment analysis, tokenization, and named entity recognition (NER), using Apple's Natural
/// Language framework. Developers can instantiate this service with or without a custom Core ML model, allowing for
/// both general-purpose and domain-specific NLP tasks.
///
/// This service acts as the bridge between the Flutter application and the native iOS/macOS Natural Language framework.
/// It communicates with native code via Method Channels to leverage advanced NLP capabilities. Developers can use the
/// default pre-trained models provided by Apple or supply custom Core ML models for specialized use cases.
///
/// ## Usage
///
/// - Use the default constructor to rely on Apple's pre-trained NLP models:
/// ```dart
/// final AppleIntelligenceNaturalLanguageService nlpService = AppleIntelligenceNaturalLanguageService();
/// ```
///
/// - Use the factory constructor to specify a custom Core ML model:
/// ```dart
/// final AppleIntelligenceNaturalLanguageService nlpServiceWithCustomModel = AppleIntelligenceNaturalLanguageService.withCustomModel('MyCustomNLPModel');
/// ```
class AppleIntelligenceNaturalLanguageService {
  /// The [MethodChannel] used for communication with the native platform code.
  static const MethodChannel _channel = MethodChannel('apple_intelligence_nlp');

  /// The name of the custom Core ML model to use, if provided.
  final String? customModelName;

  /// Default constructor for the service, using the built-in NLP models.
  AppleIntelligenceNaturalLanguageService() : customModelName = null;

  /// Factory constructor for the service with a custom Core ML model.
  factory AppleIntelligenceNaturalLanguageService.withCustomModel(String modelName) {
    return AppleIntelligenceNaturalLanguageService._internal(customModelName: modelName);
  }

  /// Internal constructor for handling initialization with or without a custom model.
  AppleIntelligenceNaturalLanguageService._internal({this.customModelName});

  /// Identifies the language of the given text.
  ///
  /// If a custom Core ML model is provided, it will be used for language identification.
  ///
  /// - [text]: The input text to analyze.
  Future<String?> identifyLanguage(String text) async {
    try {
      if (customModelName != null) {
        return await _channel.invokeMethod('identifyLanguageWithCustomModel', {
          'text': text,
          'modelName': customModelName,
        });
      } else {
        return await _channel.invokeMethod('identifyLanguage', {'text': text});
      }
    } catch (e) {
      debugPrint('Identifying language failed with error, $e');

      return null;
    }
  }

  /// Performs sentiment analysis on the given text.
  ///
  /// If a custom Core ML model is provided, it will be used for sentiment analysis.
  ///
  /// - [text]: The input text to analyze.
  Future<double?> analyzeSentiment(String text) async {
    try {
      if (customModelName != null) {
        return await _channel.invokeMethod('analyzeSentimentWithCustomModel', {
          'text': text,
          'modelName': customModelName,
        });
      } else {
        return await _channel.invokeMethod('analyzeSentiment', {'text': text});
      }
    } catch (e) {
      debugPrint('Analyzing sentiment failed with error, $e');

      return null;
    }
  }

  /// Tokenizes the input text into words or sentences.
  ///
  /// This method uses the Natural Language framework to break the input text into smaller components.
  ///
  /// - [text]: The input text to tokenize.
  /// - [unit]: The level of tokenization (e.g., word or sentence).
  Future<List<String>?> tokenize(String text, String unit) async {
    try {
      return await _channel.invokeMethod('tokenize', {'text': text, 'unit': unit}) as List<String>?;
    } catch (e) {
      debugPrint('Tokenizing text failed with error, $e');

      return null;
    }
  }

  /// Performs named entity recognition (NER) on the input text.
  ///
  /// This method identifies and classifies entities (e.g., people, places, organizations) in the text.
  ///
  /// - [text]: The input text for entity recognition.
  Future<List<Map<String, String>>?> recognizeEntities(String text) async {
    try {
      if (customModelName != null) {
        return await _channel.invokeMethod('recognizeEntitiesWithCustomModel', {
          'text': text,
          'modelName': customModelName,
        }) as List<Map<String, String>>?;
      } else {
        return await _channel.invokeMethod('recognizeEntities', {'text': text}) as List<Map<String, String>>?;
      }
    } catch (e) {
      debugPrint('Entity recognition failed with error, $e');

      return null;
    }
  }

  /// Lemmatizes the input text.
  ///
  /// This method reduces words in the input text to their base forms (e.g., "running" → "run").
  ///
  /// - [text]: The input text to lemmatize.
  Future<List<String>?> lemmatize(String text) async {
    try {
      return await _channel.invokeMethod('lemmatize', {'text': text}) as List<String>?;
    } catch (e) {
      debugPrint('Lemmatizing text failed with error, $e');

      return null;
    }
  }
}
