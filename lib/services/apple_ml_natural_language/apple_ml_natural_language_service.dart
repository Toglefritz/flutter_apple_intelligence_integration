import 'package:demo_app/services/apple_ml_natural_language/models/tokenization_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A service class for interacting with the Apple Machine Learning Natural Language (NLP) services.
///
/// This class provides an interface for performing various natural language processing tasks, such as language
/// identification, sentiment analysis, tokenization, and named entity recognition (NER), using Apple's Natural
/// Language framework. Developers can instantiate this service with or without a custom Core ML model, allowing for
/// both general-purpose and domain-specific NLP tasks.
///
/// This service acts as the bridge between the Flutter application and the native iOS/macOS Natural Language framework.
/// It communicates with native code via Method Channels to leverage advanced NLP capabilities. Developers can use the
/// default pre-trained models provided by Apple or supply custom Core ML models for specialized use cases.
class AppleMLNaturalLanguageService {
  /// The [MethodChannel] used for communication with the native platform code.
  static const MethodChannel _channel = MethodChannel('apple_ml_nlp');

  /// The name of the custom Core ML model to use, if provided.
  final String? customModelName;

  /// Default constructor for the service, using the built-in NLP models.
  AppleMLNaturalLanguageService() : customModelName = null;

  /// Factory constructor for the service with a custom Core ML model.
  factory AppleMLNaturalLanguageService.withCustomModel(String modelName) {
    return AppleMLNaturalLanguageService._internal(customModelName: modelName);
  }

  /// Internal constructor for handling initialization with or without a custom model.
  AppleMLNaturalLanguageService._internal({this.customModelName});

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

  /// Tokenizes the input text into smaller components, such as words or sentences.
  ///
  /// This function uses the Natural Language framework to segment the input text into tokens based on the specified
  /// `TokenizationUnit`. Tokenization is a key step in natural language processing, enabling downstream tasks like
  /// sentiment analysis, entity recognition, and machine learning preprocessing.
  ///
  /// ### Parameters:
  /// - [text]: A `String` containing the input text to tokenize. The input can be any valid text, but longer and
  /// contextually meaningful text yields better results.
  ///
  /// - [unit]: A `TokenizationUnit` value specifying the level of tokenization:
  ///   - `TokenizationUnit.word`: Divides the text into individual words and punctuation marks.
  ///   - `TokenizationUnit.sentence`: Divides the text into complete sentences.
  ///
  /// ### Returns:
  /// - A `List<String>?` containing the tokenized components of the input text. The result depends
  ///   on the specified unit:
  ///   - For `TokenizationUnit.word`, the list contains individual words and punctuation marks.
  ///   - For `TokenizationUnit.sentence`, the list contains full sentences.
  /// - **Special Cases**:
  ///   - If the input text is empty, the returned list will also be empty.
  ///   - If tokenization fails due to an error or unsupported input, the function returns `null`.
  ///
  /// ### Errors:
  /// - If tokenization fails, an error is logged using `debugPrint`, and `null` is returned.
  ///
  /// ### Usage:
  /// ```dart
  /// final wordTokens = await tokenize("This is a test sentence.", TokenizationUnit.word);
  /// if (wordTokens != null) {
  ///   print("Word tokens: $wordTokens");
  /// } else {
  ///   print("Failed to tokenize text into words.");
  /// }
  ///
  /// final List<String>? sentenceTokens = await tokenize("This is a test sentence. Another one follows.", TokenizationUnit.sentence);
  /// if (sentenceTokens != null) {
  ///   print("Sentence tokens: $sentenceTokens");
  /// } else {
  ///   print("Failed to tokenize text into sentences.");
  /// }
  /// ```
  Future<List<String>?> tokenize(String text, TokenizationUnit unit) async {
    try {
      // Convert the TokenizationUnit enum to a String value for the native method call.
      final String unitString = unit == TokenizationUnit.word ? 'word' : 'sentence';

      // Invoke the platform-specific method channel for tokenization.
      final List<dynamic>? result = await _channel.invokeMethod<List<dynamic>>('tokenize', {
        'text': text,
        'unit': unitString,
      });

      // Safely cast the List<dynamic> to List<String>, or return null if casting fails.
      return result?.cast<String>();
    } catch (e) {
      debugPrint('Tokenizing text failed with error, $e');

      return null;
    }
  }

  /// Performs Named Entity Recognition (NER) on the input text.
  ///
  /// Named Entity Recognition (NER) is a process in Natural Language Processing (NLP) that identifies and classifies
  /// specific entities within a text into predefined categories such as names of people, organizations, locations, and
  /// other important terms. This method utilizes Apple's Natural Language framework to perform NER on the provided
  /// text.
  ///
  /// ### Parameters:
  /// - [text]: A `String` containing the input text for entity recognition. The text should ideally contain proper
  /// nouns or structured sentences to achieve meaningful results.
  ///
  /// ### Returns:
  /// - A `List<Map<String, String>>?` where each map represents a recognized entity and its type.
  ///   Each map contains:
  ///   - `"entity"`: The identified entity as a string (e.g., `"John"`, `"Apple"`).
  ///   - `"type"`: The type of the entity (e.g., `"PersonalName"`, `"OrganizationName"`).
  ///
  /// - **Special Cases**:
  ///   - If no entities are recognized, the function returns an empty list.
  ///   - If entity recognition fails due to an error, the function returns `null`.
  ///
  /// ### Default Entity Types:
  /// The default model provided by Apple Machine Learning is capable of recognizing the following types
  /// of entities:
  /// - `"PersonalName"`: Names of people (e.g., `"John Doe"`).
  /// - `"PlaceName"`: Names of geographic locations (e.g., `"Paris"`, `"Mount Everest"`).
  /// - `"OrganizationName"`: Names of organizations (e.g., `"Apple"`, `"United Nations"`).
  ///
  /// ### Purpose:
  /// Named Entity Recognition is used to extract meaningful information from unstructured text. It is
  /// commonly used in applications like:
  /// - Text summarization: Extracting key entities for concise summaries.
  /// - Search and indexing: Improving relevance based on identified entities.
  /// - Question answering: Identifying entities to respond to queries.
  /// - Sentiment analysis: Associating sentiment with specific entities.
  ///
  /// ### Errors:
  /// - If the input text is empty or invalid, the function gracefully returns `null` without throwing an exception.
  /// - If the platform-specific implementation encounters an issue, the error is logged using `debugPrint`, and `null`
  /// is returned.
  ///
  /// ### Notes:
  /// - Custom Core ML models can be used for domain-specific NER tasks. For example, identifying product names or
  /// chemical compounds.
  /// - The accuracy of NER depends on the quality and context of the input text. Sentences with ambiguous or
  /// incomplete information may yield less accurate results.
  Future<List<Map<String, String>>?> recognizeEntities(String text) async {
    try {
      final List<dynamic>? result;

      if (customModelName != null) {
        result = await _channel.invokeMethod('recognizeEntitiesWithCustomModel', {
          'text': text,
          'modelName': customModelName,
        });
      } else {
        result = await _channel.invokeMethod('recognizeEntities', {'text': text});
      }

      // Safely map the result to a List<Map<String, String>>.
      return result?.map((item) {
        if (item is Map) {
          return item.map(
            (key, value) => MapEntry(
              key.toString(),
              value.toString(),
            ),
          );
        }

        throw Exception('Invalid item in result: $item');
      }).toList();
    } catch (e) {
      debugPrint('Entity recognition failed with error, $e');

      return null;
    }
  }

  /// Reduces words in the input text to their base or dictionary form (lemma).
  ///
  /// Lemmatization is the process of converting words in a sentence to their base or canonical form while considering
  /// the context of the word. Unlike stemming, which often trims words down without understanding their grammatical
  /// role, lemmatization uses linguistic rules and part-of-speech analysis to determine the proper base form.
  ///
  /// ### Parameters:
  /// - [text]: A `String` containing the input text to lemmatize. The text can be a single word,
  ///   phrase, or sentence, but contextually rich input improves accuracy.
  ///
  /// ### Returns:
  /// - A `List<String>?` where each item corresponds to the lemmatized form of a word or token
  ///   from the input text. For example:
  ///   - Input: `"running quickly"`
  ///   - Output: `["run", "quickly"]`
  ///
  /// - **Special Cases**:
  ///   - If the input text is empty, the function returns an empty list.
  ///   - If lemmatization fails or an error occurs, the function returns `null`.
  ///
  /// ### Use of Apple Machine Learning:
  /// This function utilizes Apple's Natural Language framework to perform lemmatization. The framework analyzes the
  /// grammatical role and context of each word in the input text to determine its appropriate lemma. For example:
  /// - `"running"` → `"run"` (verb form)
  /// - `"better"` → `"good"` (adjective form)
  ///
  /// The process ensures that lemmatization is accurate and linguistically correct across a wide range of supported
  /// languages.
  ///
  /// ### Use Cases:
  /// Lemmatization is widely used in Natural Language Processing (NLP) for tasks such as:
  /// - **Text Analysis**: Reducing word variations to a common base form for easier comparison.
  /// - **Search Optimization**: Enabling search engines to match queries like `"run"` and `"running"` to the same
  /// results.
  /// - **Sentiment Analysis**: Preprocessing text to simplify variations in word forms.
  /// - **Machine Learning**: Preparing normalized text for training NLP models.
  ///
  /// ### Example Usage:
  /// ```dart
  /// final List<String>? lemmas = await lemmatize("The children are playing happily in the playground.");
  /// if (lemmas != null) {
  ///   print("Lemmas: $lemmas");
  /// } else {
  ///   print("Failed to lemmatize the input text.");
  /// }
  /// ```
  ///
  /// **Expected Output**:
  /// ```dart
  /// Lemmas: ["The", "child", "be", "play", "happily", "in", "the", "playground"]
  /// ```
  Future<List<String>?> lemmatize(String text) async {
    try {
      final List<dynamic>? result = await _channel.invokeMethod(
        'lemmatize',
        {'text': text},
      );

      // Safely cast the List<dynamic> to List<String>, or return null if casting fails.
      return result?.cast<String>();
    } catch (e) {
      debugPrint('Lemmatizing text failed with error, $e');

      return null;
    }
  }
}
