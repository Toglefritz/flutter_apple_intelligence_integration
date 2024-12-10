import 'package:demo_app/screens/components/brutalist_button.dart';
import 'package:demo_app/screens/components/capability_window.dart';
import 'package:demo_app/screens/vision/components/example_image_tile.dart';
import 'package:demo_app/screens/vision/components/face_detection_overlay.dart';
import 'package:demo_app/screens/vision/vision_controller.dart';
import 'package:demo_app/services/apple_intelligence_vision/models/apple_intelligence_vision_capability.dart';
import 'package:demo_app/services/apple_intelligence_vision/models/vision_example_image.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A "window" containing a series of example images for which the user can request face detection.
///
/// This widget presents a "window" designed to look like it is from a 1980s computer interface. The window includes a
/// selection of images that can be submitted for face detection using Apple Intelligence. The user can click on an
/// image to request face detection and the system will return the bounding boxes for any faces detected in the image.
class FaceDetectionWindow extends StatelessWidget {
  /// Creates an instance of [FaceDetectionWindow].
  const FaceDetectionWindow({
    required this.state,
    super.key,
  });

  /// A controller for this view.
  final VisionController state;

  @override
  Widget build(BuildContext context) {
    return CapabilityWindow(
      displayFormat: CapabilityWindowDisplayFormat.fancy,
      title: AppLocalizations.of(context)!.visionFaceDetection,
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
                  image: VisionExampleImage.astronaut,
                  onTap: () => state.onSelectExampleImage(
                    image: VisionExampleImage.astronaut,
                    service: AppleIntelligenceVisionCapability.faceDetection,
                  ),
                  selected: state.selectedFaceDetectionExampleImage == VisionExampleImage.astronaut,
                ),
                ExampleImageTile(
                  image: VisionExampleImage.group,
                  onTap: () => state.onSelectExampleImage(
                    image: VisionExampleImage.group,
                    service: AppleIntelligenceVisionCapability.faceDetection,
                  ),
                  selected: state.selectedFaceDetectionExampleImage == VisionExampleImage.group,
                ),
                ExampleImageTile(
                  image: VisionExampleImage.crowd,
                  onTap: () => state.onSelectExampleImage(
                    image: VisionExampleImage.crowd,
                    service: AppleIntelligenceVisionCapability.faceDetection,
                  ),
                  selected: state.selectedFaceDetectionExampleImage == VisionExampleImage.crowd,
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
                onTap: state.onDetectFaces,
                text: AppLocalizations.of(context)!.visionFaceDetectionSubmit,
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
              '${AppLocalizations.of(context)!.visionFaceDetection}: ',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          if (state.prettyPrintFaceDetection != null)
            Padding(
              padding: const EdgeInsets.only(
                top: Inset.xxSmall,
                left: Inset.medium,
                right: Inset.medium,
                bottom: Inset.xSmall,
              ),
              child: SelectableText(
                state.prettyPrintFaceDetection!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          // Draw the face detection results on the selected image visually
          if (state.faceDetectionResult != null && state.faceDetectionImage != null)
            Center(
              child: FaceDetectionOverlay(
                image: state.faceDetectionImage!,
                size: const Size(512, 512),
                detections: state.faceDetectionResult!,
              ),
            ),
        ],
      ),
    );
  }
}
