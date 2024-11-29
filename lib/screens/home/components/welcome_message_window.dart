import 'package:demo_app/screens/components/brutalist_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A container including a welcome message.
///
/// This widget is a container designed to look like a window in 1980s versions of MacOS. The window includes a welcome
/// message for the user. The window can be dragged to change its position on the screen.
class WelcomeMessageWindow extends StatelessWidget {
  /// Creates a new instance of [WelcomeMessageWindow].
  const WelcomeMessageWindow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BrutalistContainer(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 32.0, 8.0, 64.0),
            child: Image.asset(
              'assets/apple_intelligence.png',
              width: 42,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 32.0, 64.0, 64.0),
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