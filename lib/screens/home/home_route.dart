import 'package:demo_app/screens/home/home_controller.dart';
import 'package:flutter/material.dart';

/// The [HomeRoute] is first screen presented when the app launches. It acts as the main menu for the app, presenting
/// buttons for using different Apple Intelligence features.
class HomeRoute extends StatefulWidget {
  /// Creates a new instance of [HomeRoute].
  const HomeRoute({super.key});

  @override
  HomeController createState() => HomeController();
}
