import 'package:demo_app/screens/components/checkerboard_background.dart';
import 'package:demo_app/screens/home/components/apple_intelligence_services_window.dart';
import 'package:demo_app/screens/home/components/welcome_message_window.dart';
import 'package:demo_app/screens/home/home_controller.dart';
import 'package:demo_app/screens/home/home_route.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';

/// A view for the [HomeRoute].
class HomeView extends StatelessWidget {
  /// A controller for this view.
  final HomeController state;

  /// Creates an instance of [HomeView].
  const HomeView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          CheckerboardBackground(),
          Padding(
            padding: EdgeInsets.all(
              Inset.large,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: Inset.xLarge,
                  ),
                  child: WelcomeMessageWindow(),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    Inset.xxxLarge,
                    Inset.large,
                    Inset.medium,
                    Inset.large,
                  ),
                  child: AppleIntelligencesServicesWindow(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
