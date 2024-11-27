import 'package:flutter/material.dart';

import 'home_controller.dart';

/// A view for the [HomeRoute].
class HomeView extends StatelessWidget {
  /// A controller for this view.
  final HomeController state;

  /// Creates an instance of [HomeView].
  const HomeView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Placeholder(),
    );
  }
}
