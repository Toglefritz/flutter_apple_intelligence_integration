import 'package:demo_app/screens/vision/components/image_classification_window.dart';
import 'package:demo_app/screens/vision/components/vision_welcome_window.dart';
import 'package:demo_app/screens/vision/vision_controller.dart';
import 'package:demo_app/screens/vision/vision_route.dart';
import 'package:demo_app/values/image_asset.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';

/// A view for the [VisionRoute].
class VisionView extends StatelessWidget {
  /// A controller for this view.
  final VisionController state;

  /// Creates an instance of [VisionView].
  const VisionView(this.state, {super.key});

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
                  const VisionWelcomeWindow(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Inset.large,
                      vertical: Inset.medium,
                    ),
                    child: ImageClassificationWindow(state: state),
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
