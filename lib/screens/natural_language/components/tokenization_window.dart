import 'package:demo_app/screens/components/capability_window.dart';
import 'package:demo_app/screens/natural_language/natural_language_controller.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A "window" containing a text input field for collecting text to be tokenized using Apple Machine Learning and a
/// display  for the tokenized text.
///
/// This widget presents a "window" designed to look like it is from a 1980s computer interface. The window includes a
/// text input field for collecting text that will be tokenized using Apple ML and a display for the tokenized
/// text. The tokenization is performed by Apple ML. Initially, the tokenized text is unknown (because no text
/// has been submitted for tokenization). When the user submits text for tokenization, the tokenized text is displayed in
/// the window.
class TokenizationWindow extends StatelessWidget {
  /// Creates an instance of [TokenizationWindow].
  const TokenizationWindow({
    required this.state,
    super.key,
  });

  /// A controller for this view.
  final NaturalLanguageController state;

  @override
  Widget build(BuildContext context) {
    return CapabilityWindow(
      displayFormat: CapabilityWindowDisplayFormat.plain,
      title: AppLocalizations.of(context)!.naturalLanguageTokenization,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // A text field collecting text for language identification
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Inset.medium,
            ),
            child: TextField(
              controller: state.tokenizeTextController,
              onSubmitted: state.onTokenize,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: state.onTokenize,
                  child: Icon(
                    Icons.content_cut,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Divider(
                color: Theme.of(context).primaryColor,
                height: Inset.medium,
                thickness: Inset.xxxSmall,
                indent: Inset.small,
                endIndent: Inset.small,
              ),
              const ColoredBox(
                color: Colors.white,
                child: Icon(
                  Icons.arrow_downward_sharp,
                  size: 14,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 28),
                child: ColoredBox(
                  color: Colors.white,
                  child: Icon(
                    Icons.arrow_downward_sharp,
                    size: 14,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 28),
                child: ColoredBox(
                  color: Colors.white,
                  child: Icon(
                    Icons.arrow_downward_sharp,
                    size: 14,
                  ),
                ),
              ),
            ],
          ),

          // A text representation of the identified sentiment
          Padding(
            padding: const EdgeInsets.only(
              left: Inset.medium,
              top: Inset.small,
              right: Inset.medium,
            ),
            child: Text(
              '${AppLocalizations.of(context)!.naturalLanguageTokenizedText}:',
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
                state.tokenizedText.toString(),
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
