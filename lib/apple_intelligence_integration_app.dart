import 'package:demo_app/screens/home/home_route.dart';
import 'package:demo_app/theme/apple_intelligence_integration_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// The [AppleIntelligenceIntegrationApp] is the root widget for the Contact Abyss game. It includes the [MaterialApp]
/// widget that acts as the root of the widget tree and provides navigation and theming for the app.
class AppleIntelligenceIntegrationApp extends StatelessWidget {
  /// Creates an instance of [AppleIntelligenceIntegrationApp].
  const AppleIntelligenceIntegrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apple Intelligence Demo',
      theme: AppleIntelligenceIntegrationAppTheme.themeData,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeRoute(),
    );
  }
}
