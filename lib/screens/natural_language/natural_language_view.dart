import 'package:demo_app/screens/natural_language/components/language_identification_window.dart';
import 'package:demo_app/screens/natural_language/components/named_entity_recognition_window.dart';
import 'package:demo_app/screens/natural_language/components/natural_language_welcome_window.dart';
import 'package:demo_app/screens/natural_language/components/sentiment_analysis_window.dart';
import 'package:demo_app/screens/natural_language/components/tokenization_window.dart';
import 'package:demo_app/screens/natural_language/natural_language_controller.dart';
import 'package:demo_app/screens/natural_language/natural_language_route.dart';
import 'package:demo_app/values/image_asset.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';

/// A view for the [NaturalLanguageRoute].
class NaturalLanguageView extends StatelessWidget {
  /// A controller for this view.
  final NaturalLanguageController state;

  /// Creates an instance of [NaturalLanguageView].
  const NaturalLanguageView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Back button
          Positioned(
            top: Inset.small,
            left: Inset.small,
            child: GestureDetector(
              onTap: state.onBack,
              child: Image.asset(
                ImageAsset.arrowIcon.path,
                width: 24,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(
              Inset.large,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const NaturalLanguageWelcomeWindow(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Inset.large,
                      vertical: Inset.medium,
                    ),
                    child: LanguageIdentificationWindow(state: state),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Inset.large,
                    ),
                    child: SentimentAnalysisWindow(state: state),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Inset.large,
                      vertical: Inset.medium,
                    ),
                    child: TokenizationWindow(state: state),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Inset.large,
                    ),
                    child: NamedEntityRecognitionWindow(state: state),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
