import 'package:demo_app/screens/natural_language/natural_language_controller.dart';
import 'package:flutter/material.dart';

/// The [NaturalLanguageRoute] contains a series of windows that demonstrate each of the natural language features
/// available in the Apple Machine Learning services.
class NaturalLanguageRoute extends StatefulWidget {
  /// Creates a new instance of [NaturalLanguageRoute].
  const NaturalLanguageRoute({super.key});

  @override
  NaturalLanguageController createState() => NaturalLanguageController();
}
