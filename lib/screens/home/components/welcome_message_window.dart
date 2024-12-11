import 'package:demo_app/screens/components/brutalist_container.dart';
import 'package:demo_app/values/image_asset.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A container including a welcome message.
///
/// This widget is a container designed to look like a window in 1980s versions of MacOS. The window includes a welcome
/// message for the user.
class WelcomeMessageWindow extends StatelessWidget {
  /// Creates a new instance of [WelcomeMessageWindow].
  const WelcomeMessageWindow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BrutalistContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(
              Inset.large,
            ),
            child: Image.asset(
              ImageAsset.appIcon.path,
              width: 42,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: Inset.large,
            ),
            child: Text(
              AppLocalizations.of(context)!.welcomeMessage,
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
