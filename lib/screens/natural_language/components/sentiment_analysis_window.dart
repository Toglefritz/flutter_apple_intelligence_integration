import 'package:demo_app/screens/natural_language/components/natural_language_capability_window.dart';
import 'package:demo_app/screens/natural_language/natural_language_controller.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A "window" containing a text input field for collecting text for sentiment analysis and a display for the
/// identified sentiment.
///
/// This widget presents a "window" designed to look like it is from a 1980s computer interface. The window includes a
/// text input field for collecting text for sentiment analysis and a display for the identified sentiment.
class SentimentAnalysisWindow extends StatelessWidget {
  /// Creates an instance of [SentimentAnalysisWindow].
  const SentimentAnalysisWindow({
    required this.state,
    super.key,
  });

  /// A controller for this view.
  final NaturalLanguageController state;

  @override
  Widget build(BuildContext context) {
    return NaturalLanguageCapabilityWindow(
      displayFormat: NaturalLanguageCapabilityWindowDisplayFormat.striped,
      title: AppLocalizations.of(context)!.naturalLanguageSentimentAnalysis,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // A text field collecting text for language identification
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Inset.medium,
            ),
            child: TextField(
              controller: state.analyzeSentimentTextController,
              onSubmitted: state.onAnalyzeSentiment,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: state.onAnalyzeSentiment,
                  child: Icon(
                    Icons.thumbs_up_down,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
          // A visual representation of the identified sentiment
          Padding(
            padding: const EdgeInsets.only(
              left: Inset.medium,
              top: Inset.small,
              right: Inset.medium,
            ),
            child: LinearProgressIndicator(
              // Normalize the sentiment value to a range of 0.0 to 1.0 from its original range of -1.0 to 1.0
              value: state.identifiedSentiment == null ? 0.5 : (state.identifiedSentiment! + 1.0) / 2.0,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
              minHeight: 6.0,
              valueColor: AlwaysStoppedAnimation<Color>(
                state.identifiedSentiment == null
                    ? Theme.of(context).primaryColor.withOpacity(0.5)
                    : state.identifiedSentiment! > 0
                        ? Colors.green[800]!
                        : Colors.red[800]!,
              ),
            ),
          ),
          // A text representation of the identified sentiment
          Padding(
            padding: const EdgeInsets.only(
              left: Inset.medium,
              top: Inset.small,
              right: Inset.medium,
            ),
            child: RichText(
              text: TextSpan(
                text: '${AppLocalizations.of(context)!.naturalLanguageSentimentScore}: ',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
                children: [
                  TextSpan(
                    text: state.identifiedSentiment == null ? '' : state.identifiedSentiment.toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
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
