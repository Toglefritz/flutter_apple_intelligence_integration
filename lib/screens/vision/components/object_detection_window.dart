import 'package:demo_app/screens/components/brutalist_button.dart';
import 'package:demo_app/screens/components/capability_window.dart';
import 'package:demo_app/screens/vision/components/example_image_tile.dart';
import 'package:demo_app/screens/vision/components/object_detection_overlay.dart';
import 'package:demo_app/screens/vision/vision_controller.dart';
import 'package:demo_app/services/apple_ml_vision/models/apple_ml_vision_capability.dart';
import 'package:demo_app/services/apple_ml_vision/models/vision_example_image.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A "window" containing a series of example images for which the user can request object detection.
///
/// This widget presents a "window" designed to look like it is from a 1980s computer interface. The window includes a
/// selection of images that can be submitted for object detection using Apple Machine Learning. The user can click on
/// an image to request object detection.
class ObjectDetectionWindow extends StatelessWidget {
  /// Creates an instance of [ObjectDetectionWindow].
  const ObjectDetectionWindow({
    required this.state,
    super.key,
  });

  /// A controller for this view.
  final VisionController state;

  @override
  Widget build(BuildContext context) {
    return CapabilityWindow(
      displayFormat: CapabilityWindowDisplayFormat.plain,
      title: AppLocalizations.of(context)!.visionObjectDetection,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: Inset.medium,
              bottom: Inset.small,
            ),
            child: Text(
              AppLocalizations.of(context)!.visionSelectExampleImage,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          // A set of example images to be used for classification
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Inset.medium,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ExampleImageTile(
                  image: VisionExampleImage.deskScene,
                  onTap: () => state.onSelectExampleImage(
                    image: VisionExampleImage.deskScene,
                    service: AppleMLVisionCapability.objectDetection,
                  ),
                  selected: state.selectedObjectDetectionExampleImage == VisionExampleImage.deskScene,
                ),
                ExampleImageTile(
                  image: VisionExampleImage.natureScene,
                  onTap: () => state.onSelectExampleImage(
                    image: VisionExampleImage.natureScene,
                    service: AppleMLVisionCapability.objectDetection,
                  ),
                  selected: state.selectedObjectDetectionExampleImage == VisionExampleImage.natureScene,
                ),
                ExampleImageTile(
                  image: VisionExampleImage.foodScene,
                  onTap: () => state.onSelectExampleImage(
                    image: VisionExampleImage.foodScene,
                    service: AppleMLVisionCapability.objectDetection,
                  ),
                  selected: state.selectedObjectDetectionExampleImage == VisionExampleImage.foodScene,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: Inset.small,
              bottom: Inset.xSmall,
            ),
            child: Center(
              child: BrutalistButton(
                onTap: state.onDetectObjects,
                text: AppLocalizations.of(context)!.visionObjectDetectionSubmit,
              ),
            ),
          ),
          Divider(
            thickness: Inset.xxxSmall,
            color: Theme.of(context).primaryColor,
            indent: Inset.medium,
            endIndent: Inset.medium,
          ),
          // Display the image classification result
          Padding(
            padding: const EdgeInsets.only(
              top: Inset.small,
              left: Inset.medium,
              right: Inset.medium,
              bottom: Inset.xSmall,
            ),
            child: Text(
              '${AppLocalizations.of(context)!.visionObjectDetection}: ',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          if (state.prettyPrintObjectDetection != null)
            Padding(
              padding: const EdgeInsets.only(
                top: Inset.xxSmall,
                left: Inset.medium,
                right: Inset.medium,
                bottom: Inset.xSmall,
              ),
              child: SelectableText(
                state.prettyPrintObjectDetection!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          // Draw the object detection results on the selected image visually
          if (state.objectDetectionResult != null && state.objectDetectionImage != null)
            Center(
              child: ObjectDetectionOverlay(
                image: state.objectDetectionImage!,
                size: const Size(512, 512),
                detections: state.objectDetectionResult!,
              ),
            ),
        ],
      ),
    );
  }
}
