import 'package:demo_app/screens/home/home_route.dart';
import 'package:demo_app/screens/home/home_view.dart';
import 'package:demo_app/screens/natural_language/natural_language_route.dart';
import 'package:demo_app/services/models/apple_intelligence_service.dart';
import 'package:flutter/material.dart';

/// A controller for the [HomeRoute].
class HomeController extends State<HomeRoute> {
  /// A handler for taps on the badges representing services from Apple Intelligence.
  void onServiceTap(AppleIntelligenceService service) {
    // Navigate to the route corresponding to the service.
    switch (service) {
      case AppleIntelligenceService.naturalLanguageProcessing:
        onNaturalLanguageButtonTap();
      case AppleIntelligenceService.sound:
        onSoundButtonTap();
      case AppleIntelligenceService.speechRecognition:
        onSpeechRecognitionButtonTap();
      case AppleIntelligenceService.translation:
        onTranslationButtonTap();
      case AppleIntelligenceService.vision:
        onVisionButtonTap();
    }
  }

  /// Called when the user taps the "Natural Language" button.
  void onNaturalLanguageButtonTap() {
    // Navigate to the Natural Language route with a fade animation.
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondaryAnimation) => const NaturalLanguageRoute(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
  }

  /// Called when the user taps the "Sound" button.
  void onSoundButtonTap() {
    // TODO(Toglefritz): Implement this method.
  }

  /// Called when the user taps the "Speech Recognition" button.
  void onSpeechRecognitionButtonTap() {
    // TODO(Toglefritz): Implement this method.
  }

  /// Called when the user taps the "Translation" button.
  void onTranslationButtonTap() {
    // TODO(Toglefritz): Implement this method.
  }

  /// Called when the user taps the "Vision" button.
  void onVisionButtonTap() {
    // TODO(Toglefritz): Implement this method.
  }

  @override
  Widget build(BuildContext context) => HomeView(this);
}
