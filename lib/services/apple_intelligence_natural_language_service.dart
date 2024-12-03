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
  /// This function leverages Apple's Natural Language framework to analyze the provided text and determine the most
  /// likely language. If a custom Core ML model is supplied during initialization, that model will be used for
  /// language identification instead of the built-in language detection capabilities.
  ///
  /// ### Parameters:
  /// - [text]: A `String` containing the input text to analyze. This should be a sufficiently long and representative
  /// sample for accurate language detection. Very short or ambiguous text may lead to inaccurate results.
  ///
  /// ### Returns:
  /// - A `String?` representing the identified language code in the BCP 47 format (e.g., `"en"`, `"fr"`, `"es"`), which
  /// conforms to industry standards for language tags. The return value indicates the detected language of the input
  /// text.
  /// - **Examples of Possible Return Values**:
  ///   - `"en"`: English
  ///   - `"fr"`: French
  ///   - `"es"`: Spanish
  ///   - `"ar"`: Arabic
  ///
  /// - **Special Cases**:
  ///   - `null`: Indicates that the language could not be reliably identified. This can occur if the input text is too
  ///   short, ambiguous, or not supported by the language model in use.
  ///
  /// ### Usage:
  /// ```dart
  /// final String? languageCode = await identifyLanguage("Bonjour tout le monde");
  /// if (languageCode != null) {
  ///   print("The identified language is: $languageCode");
  /// } else {
  ///   print("The language could not be identified.");
  /// }
  /// ```
  ///
  /// ### Notes:
  /// - Language detection accuracy improves with longer and contextually meaningful input text.
  /// - For custom models, ensure the provided Core ML model is properly configured to handle language detection and
  /// supports the expected input language set.
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
  /// This function uses Apple's Natural Language framework to evaluate the sentiment of the provided text and returns
  /// a numerical sentiment score. If a custom Core ML model is supplied during initialization, that model will be used
  /// for sentiment analysis instead of the built-in sentiment analysis capabilities.
  ///
  /// ### Parameters:
  /// - [text]: A `String` containing the input text to analyze. The text should be meaningful and contextually rich
  /// to ensure accurate sentiment evaluation. Very short or ambiguous text may result in less reliable sentiment scores.
  ///
  /// ### Returns:
  /// - A `double?` representing the sentiment score of the input text. The score is interpreted as follows:
  ///   - **Positive Sentiment**:
  ///     - Scores closer to `1.0` indicate strong positive sentiment.
  ///     - Example: "I love this app!" → `0.95`
  ///   - **Neutral Sentiment**:
  ///     - Scores around `0.0` indicate neutral or mixed sentiment.
  ///     - Example: "This is an app." → `0.0`
  ///   - **Negative Sentiment**:
  ///     - Scores closer to `-1.0` indicate strong negative sentiment.
  ///     - Example: "I hate this app." → `-0.85`
  /// - **Special Cases**:
  ///   - `null`: Indicates that sentiment analysis could not be performed, likely due to an error or unsupported input
  ///   text.
  ///
  /// ### Notes:
  /// - Sentiment scores are calculated based on the contextual meaning of the text and may vary depending on the
  /// language and phrasing.
  /// - For custom models, ensure the provided Core ML model is trained specifically for sentiment analysis and supports
  /// the language of the input text.
  ///
  /// ### Example Usage:
  /// ```dart
  /// final double? sentimentScore = await analyzeSentiment("I absolutely love iPhone!");
  /// if (sentimentScore != null) {
  ///   if (sentimentScore > 0) {
  ///     print("The sentiment is positive: $sentimentScore");
  ///   } else if (sentimentScore < 0) {
  ///     print("The sentiment is negative: $sentimentScore");
  ///   } else {
  ///     print("The sentiment is neutral.");
  ///   }
  /// } else {
  ///   print("Sentiment analysis could not be performed.");
  /// }
  /// ```
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
