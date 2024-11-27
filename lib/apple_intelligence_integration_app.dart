import 'package:demo_app/screens/home/home_route.dart';
import 'package:flutter/material.dart';

/// The [AppleIntelligenceIntegrationApp] is the root widget for the Contact Abyss game. It includes the [MaterialApp]
/// widget that acts as the root of the widget tree and provides navigation and theming for the app.
class AppleIntelligenceIntegrationApp extends StatelessWidget {
  /// Creates an instance of [AppleIntelligenceIntegrationApp].
  const AppleIntelligenceIntegrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const HomeRoute(),
    );
  }
}