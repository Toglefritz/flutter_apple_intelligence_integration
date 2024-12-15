import 'package:demo_app/screens/sound/components/sound_file_classification_window.dart';
import 'package:demo_app/screens/sound/components/sound_welcome_window.dart';
import 'package:demo_app/screens/sound/sound_controller.dart';
import 'package:demo_app/values/image_asset.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';

/// A view for the [SoundView].
class SoundView extends StatelessWidget {
  /// A controller for this view.
  final SoundController state;

  /// Creates an instance of [SoundView].
  const SoundView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Back button
          Positioned(
            top: Inset.small,
            left: Inset.small,
            child: GestureDetector(
              onTap: state.onBack,
              child: Image.asset(
                ImageAsset.arrowIcon.path,
                width: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
              Inset.large,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SoundWelcomeWindow(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Inset.large,
                      vertical: Inset.medium,
                    ),
                    child: SoundFileClassificationWindow(state: state),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
