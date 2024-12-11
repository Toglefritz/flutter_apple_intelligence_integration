import 'package:demo_app/screens/home/home_route.dart';
import 'package:demo_app/theme/apple_ml_integration_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// The [AppleMLIntegrationApp] is the root widget for the Contact Abyss game. It includes the [MaterialApp] widget
/// that acts as the root of the widget tree and provides navigation and theming for the app.
class AppleMLIntegrationApp extends StatelessWidget {
  /// Creates an instance of [AppleMLIntegrationApp].
  const AppleMLIntegrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apple ML Demo',
      theme: AppleMLIntegrationAppTheme.themeData,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeRoute(),
    );
  }
}
