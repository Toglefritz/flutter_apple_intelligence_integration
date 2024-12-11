import 'package:demo_app/screens/components/capability_window.dart';
import 'package:demo_app/screens/natural_language/natural_language_controller.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A "window" containing a text input field for collecting text for language identification and a display for the
/// identified language.
///
/// This widget presents a "window" designed to look like it is from a 1980s computer interface. The window includes a
/// text input field for collecting text for language identification and a display for the identified language.
/// The language identification is performed by Apple Machine Learning. Initially, the language is unknown (because no
/// text has been submitted for identification). When the user submits text for identification, the identified language
/// is displayed in the window.
class LanguageIdentificationWindow extends StatelessWidget {
  /// Creates an instance of [LanguageIdentificationWindow].
  const LanguageIdentificationWindow({
    required this.state,
    super.key,
  });

  /// A controller for this view.
  final NaturalLanguageController state;

  @override
  Widget build(BuildContext context) {
    return CapabilityWindow(
      displayFormat: CapabilityWindowDisplayFormat.fancy,
      title: AppLocalizations.of(context)!.naturalLanguageIdentifyLanguage,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // A text field collecting text for language identification
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Inset.medium,
            ),
            child: TextField(
              controller: state.identifyLanguageTextController,
              onSubmitted: state.onIdentifyLanguage,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: state.onIdentifyLanguage,
                  child: Icon(
                    Icons.language,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
          // A container for displaying the identified language
          Padding(
            padding: const EdgeInsets.only(
              left: Inset.medium,
              top: Inset.small,
              right: Inset.medium,
            ),
            child: RichText(
              text: TextSpan(
                text: '${AppLocalizations.of(context)!.naturalLanguageIdentifiedLanguage}: ',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                children: [
                  TextSpan(
                    text: state.identifiedLanguage,
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
