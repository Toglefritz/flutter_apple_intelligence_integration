import 'package:demo_app/screens/natural_language/components/natural_language_capability_window.dart';
import 'package:demo_app/screens/natural_language/components/natural_language_welcome_window.dart';
import 'package:demo_app/screens/natural_language/natural_language_controller.dart';
import 'package:demo_app/screens/natural_language/natural_language_route.dart';
import 'package:demo_app/values/image_asset.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            child: Column(
              children: [
                const NaturalLanguageWelcomeWindow(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Inset.large,
                    vertical: Inset.medium,
                  ),
                  child: NaturalLanguageCapabilityWindow(
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
                                  Icons.arrow_forward,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // A container for displaying the identified language
                        Container(
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
