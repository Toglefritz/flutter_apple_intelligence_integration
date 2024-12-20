import 'package:demo_app/screens/home/home_route.dart';
import 'package:demo_app/screens/home/home_view.dart';
import 'package:demo_app/screens/natural_language/natural_language_route.dart';
import 'package:demo_app/screens/sound/sound_route.dart';
import 'package:demo_app/screens/vision/vision_route.dart';
import 'package:demo_app/services/apple_machine_learning_service.dart';
import 'package:flutter/material.dart';

/// A controller for the [HomeRoute].
class HomeController extends State<HomeRoute> {
  /// A handler for taps on the badges representing services from Apple Machine Learning.
  void onServiceTap(AppleMachineLearningService service) {
    // Navigate to the route corresponding to the service.
    switch (service) {
      case AppleMachineLearningService.naturalLanguageProcessing:
        onNaturalLanguageButtonTap();
      case AppleMachineLearningService.sound:
        onSoundButtonTap();
      case AppleMachineLearningService.vision:
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
    // Navigate to the Sound route with a fade animation.
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondaryAnimation) => const SoundRoute(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
  }

  /// Called when the user taps the "Vision" button.
  void onVisionButtonTap() {
    // Navigate to the Vision route with a fade animation.
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondaryAnimation) => const VisionRoute(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => HomeView(this);
}
