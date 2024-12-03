import 'package:demo_app/screens/components/capability_window.dart';
import 'package:demo_app/screens/natural_language/natural_language_controller.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A "window" containing a text input field for collecting text to be lemmatized using Apple Intelligence and a display
/// for the lemmatized text.
///
/// This widget presents a "window" designed to look like it is from a 1980s computer interface. The window includes a
/// text input field for collecting text that will be lemmatized using Apple Intelligence and a display for the
/// lemmatized text. The lemmatization is performed by Apple Intelligence.
class LemmatizationWindow extends StatelessWidget {
  /// Creates an instance of [LemmatizationWindow].
  const LemmatizationWindow({
    required this.state,
    super.key,
  });

  /// A controller for this view.
  final NaturalLanguageController state;

  @override
  Widget build(BuildContext context) {
    return CapabilityWindow(
      displayFormat: CapabilityWindowDisplayFormat.fancy,
      title: AppLocalizations.of(context)!.naturalLanguageLemmatization,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // A text field collecting text for language identification
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Inset.medium,
            ),
            child: TextField(
              controller: state.lemmatizeTextController,
              onSubmitted: state.onLemmatize,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: state.onLemmatize,
                  child: Icon(
                    Icons.carpenter_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
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
            child: Text(
              '${AppLocalizations.of(context)!.naturalLanguageLemmatizedText}:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          if (state.tokenizedText != null)
            Padding(
              padding: const EdgeInsets.only(
                left: Inset.large,
                top: Inset.small,
                right: Inset.large,
              ),
              child: Text(
                state.lemmatizedText.toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
