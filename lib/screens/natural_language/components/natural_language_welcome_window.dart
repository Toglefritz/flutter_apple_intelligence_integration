import 'package:demo_app/screens/components/brutalist_container.dart';
import 'package:demo_app/values/image_asset.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A container including a welcome message.
///
/// This widget is a container designed to look like a window in 1980s versions of MacOS. The window includes a welcome
/// message for the user.
class NaturalLanguageWelcomeWindow extends StatelessWidget {
  /// Creates a new instance of [NaturalLanguageWelcomeWindow].
  const NaturalLanguageWelcomeWindow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BrutalistContainer(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Inset.large,
              Inset.large,
              Inset.small,
              Inset.large,
            ),
            child: Image.asset(
              ImageAsset.nlpIcon.path,
              width: 42,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Inset.small,
              Inset.large,
              Inset.xLarge,
              Inset.large,
            ),
            child: Text(
              AppLocalizations.of(context)!.naturalLanguageWelcomeMessage,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
