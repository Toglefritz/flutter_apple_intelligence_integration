import 'package:demo_app/screens/components/brutalist_button.dart';
import 'package:demo_app/screens/components/capability_window.dart';
import 'package:demo_app/screens/vision/components/example_image_tile.dart';
import 'package:demo_app/screens/vision/vision_controller.dart';
import 'package:demo_app/services/apple_ml_vision/models/apple_ml_vision_capability.dart';
import 'package:demo_app/services/apple_ml_vision/models/vision_example_image.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A "window" containing a series of example images for which the user can request classification.
///
/// This widget presents a "window" designed to look like it is from a 1980s computer interface. The window includes a
/// selection of images that can be submitted for classification using Apple Machine Learning services. The user can
/// click on an image to request classification.
class ImageClassificationWindow extends StatelessWidget {
  /// Creates an instance of [ImageClassificationWindow].
  const ImageClassificationWindow({
    required this.state,
    super.key,
  });

  /// A controller for this view.
  final VisionController state;

  @override
  Widget build(BuildContext context) {
    return CapabilityWindow(
      displayFormat: CapabilityWindowDisplayFormat.fancy,
      title: AppLocalizations.of(context)!.visionClassifyImage,
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
                  image: VisionExampleImage.flower,
                  onTap: () => state.onSelectExampleImage(
                    image: VisionExampleImage.flower,
                    service: AppleMLVisionCapability.classification,
                  ),
                  selected: state.selectedClassificationExampleImage == VisionExampleImage.flower,
                ),
                ExampleImageTile(
                  image: VisionExampleImage.dog,
                  onTap: () => state.onSelectExampleImage(
                    image: VisionExampleImage.dog,
                    service: AppleMLVisionCapability.classification,
                  ),
                  selected: state.selectedClassificationExampleImage == VisionExampleImage.dog,
                ),
                ExampleImageTile(
                  image: VisionExampleImage.chair,
                  onTap: () => state.onSelectExampleImage(
                    image: VisionExampleImage.chair,
                    service: AppleMLVisionCapability.classification,
                  ),
                  selected: state.selectedClassificationExampleImage == VisionExampleImage.chair,
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
                onTap: state.onClassifyImage,
                text: AppLocalizations.of(context)!.visionClassifySubmit,
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
              '${AppLocalizations.of(context)!.visionImageClassification}: ',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          if (state.prettyPrintImageClassification != null)
            Padding(
              padding: const EdgeInsets.only(
                top: Inset.xxSmall,
                left: Inset.medium,
                right: Inset.medium,
                bottom: Inset.xSmall,
              ),
              child: Text(
                state.prettyPrintImageClassification!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
