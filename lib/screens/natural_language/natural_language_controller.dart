import 'package:demo_app/screens/natural_language/natural_language_route.dart';
import 'package:demo_app/screens/natural_language/natural_language_view.dart';
import 'package:demo_app/services/apple_intelligence_natural_language_service.dart';
import 'package:flutter/material.dart';

/// A controller for the [NaturalLanguageRoute].
class NaturalLanguageController extends State<NaturalLanguageRoute> {
  /// A service for using the natural language processing capabilities of Apple Intelligence.
  final AppleIntelligenceNaturalLanguageService _naturalLanguageService = AppleIntelligenceNaturalLanguageService();

  /// A [TextEditingController] for the text field used to collect text for which Apple Intelligence will identify the
  /// language.
  final TextEditingController identifyLanguageTextController = TextEditingController();

  /// A string representation of the language identified by Apple Intelligence for text submitted by the user.
  String? identifiedLanguage;

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

  @override
  Widget build(BuildContext context) => NaturalLanguageView(this);
}
