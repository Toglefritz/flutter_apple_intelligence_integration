import 'package:demo_app/screens/natural_language/natural_language_route.dart';
import 'package:demo_app/screens/natural_language/natural_language_view.dart';
import 'package:demo_app/services/apple_intelligence_natural_language/apple_intelligence_natural_language_service.dart';
import 'package:demo_app/services/apple_intelligence_natural_language/models/tokenization_unit.dart';
import 'package:flutter/material.dart';

/// A controller for the [NaturalLanguageRoute].
class NaturalLanguageController extends State<NaturalLanguageRoute> {
  /// A service for using the natural language processing capabilities of Apple Intelligence.
  final AppleIntelligenceNaturalLanguageService _naturalLanguageService = AppleIntelligenceNaturalLanguageService();

  /// A [TextEditingController] for the text field used to collect text for which Apple Intelligence will identify the
  /// language.
  final TextEditingController identifyLanguageTextController = TextEditingController();

  /// A [TextEditingController] for the text field used to collect text for which Apple Intelligence will analyze the
  /// sentiment.
  final TextEditingController analyzeSentimentTextController = TextEditingController();

  /// A [TextEditingController] for the text field used to submit text for tokenization via the Apple Intelligence
  /// service.
  final TextEditingController tokenizeTextController = TextEditingController();

  /// A [TextEditingController] for the text field used to collect text to be processed by named entity recognition.
  final TextEditingController namedEntityRecognitionTextController = TextEditingController();

  /// A string representation of the language identified by Apple Intelligence for text submitted by the user.
  ///
  /// This value is set when the user submits text for which to identify the language. The value is a string
  /// representation of a language code in the BCP 47 format (e.g., `"en"`, `"fr"`, `"es"`), which conforms to industry
  /// standards for language tags.
  String? identifiedLanguage;

  /// A string representation of the sentiment identified by Apple Intelligence for text submitted by the user.
  ///
  /// This value is set when the user submits text for which to analyze the sentiment. The value is a double
  /// representing the sentiment score, which ranges from -1.0 (most negative) to 1.0 (most positive).
  double? identifiedSentiment;

  /// A tokenized string based on the text submitted by the user.
  List<String>? tokenizedText;

  /// A list of named entities identified by Apple Intelligence for text submitted by the user.
  List<Map<String, String>>? namedEntities;

  /// Called when the back button is tapped.
  void onBack() {
    // Pop the current route off the navigator and go back to the HomeRoute.
    Navigator.of(context).pop();
  }

  /// Called when the user submits text for which to identify the language.
  Future<void> onIdentifyLanguage([String? text]) async {
    final String textInput = text ?? identifyLanguageTextController.text;

    debugPrint('Identifying language for text, $textInput');

    // Use the natural language service to identify the language of the text.
    final String? language = await _naturalLanguageService.identifyLanguage(textInput);

    debugPrint('Identified language as $language');

    setState(() {
      identifiedLanguage = language;
    });
  }

  /// Called when the user submits text for which to analyze the sentiment.
  Future<void> onAnalyzeSentiment([String? text]) async {
    final String textInput = text ?? analyzeSentimentTextController.text;

    debugPrint('Analyzing sentiment for text, $textInput');

    // Use the natural language service to analyze the sentiment of the text.
    final double? sentiment = await _naturalLanguageService.analyzeSentiment(textInput);

    debugPrint('Identified sentiment as $sentiment');

    setState(() {
      identifiedSentiment = sentiment;
    });
  }

  /// Called when the user submits text to be tokenized.
  Future<void> onTokenize([String? text]) async {
    final String textInput = text ?? tokenizeTextController.text;

    debugPrint('Tokenizing text, $textInput');

    // Use the natural language service to tokenize the text.
    final List<String>? tokenized = await _naturalLanguageService.tokenize(textInput, TokenizationUnit.word);

    debugPrint('Tokenized text as $tokenized');

    setState(() {
      tokenizedText = tokenized;
    });
  }

  /// Called when the user submits text for which to perform named entity recognition.
  Future<void> onRecognizeNamedEntities([String? text]) async {
    final String textInput = text ?? namedEntityRecognitionTextController.text;

    debugPrint('Recognizing named entities for text, $textInput');

    // Use the natural language service to recognize named entities in the text.
    final List<Map<String, String>>? entities = await _naturalLanguageService.recognizeEntities(textInput);

    debugPrint('Recognized named entities as $entities');

    setState(() {
      namedEntities = entities;
    });
  }

  @override
  Widget build(BuildContext context) => NaturalLanguageView(this);
}
