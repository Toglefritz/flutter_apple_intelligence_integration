import 'package:demo_app/services/apple_intelligence_vision/models/vision_example_image.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';

/// A container displaying an example image for demonstrating Apple Intelligence vision features.
///
/// This widget displays an example image that can be used to demonstrate the capabilities of the Apple Intelligence
/// Vision. The image can be displayed in a `selected` state. In this state, a border is drawn around the image. In the
/// unselected state, no border is drawn.
class ExampleImageTile extends StatelessWidget {
  /// Creates an instance of [ExampleImageTile].
  const ExampleImageTile({
    required this.image,
    required this.onTap,
    required this.selected,
    super.key,
  });

  /// The image displayed in this widget.
  final VisionExampleImage image;

  /// A function called when the image is tapped.
  final void Function() onTap;

  /// Determines if the image is in a "selected" state. If `true`, a border is drawn around the image.
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: selected
              ? Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2.0,
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            Inset.xxxSmall,
          ),
          child: Image.asset(
            image.path,
            width: 128,
            height: 128,
          ),
        ),
      ),
    );
  }
}
