import 'package:demo_app/screens/home/components/apple_ml_services_window.dart';
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
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(
              Inset.large,
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Inset.medium,
                  ),
                  child: WelcomeMessageWindow(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Inset.xLarge,
                    vertical: Inset.medium,
                  ),
                  child: AppleMLServicesWindow(
                    onServiceTapped: state.onServiceTap,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
