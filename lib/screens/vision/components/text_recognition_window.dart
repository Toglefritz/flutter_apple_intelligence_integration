import 'package:demo_app/screens/components/brutalist_button.dart';
import 'package:demo_app/screens/components/capability_window.dart';
import 'package:demo_app/screens/vision/components/example_image_tile.dart';
import 'package:demo_app/screens/vision/vision_controller.dart';
import 'package:demo_app/services/apple_ml_vision/models/apple_ml_vision_capability.dart';
import 'package:demo_app/services/apple_ml_vision/models/vision_example_image.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A "window" containing a series of example images for which the user can request text recognition.
///
/// This widget presents a "window" designed to look like it is from a 1980s computer interface. The window includes a
/// selection of images that can be submitted for text recognition using Apple Machine Learning. The user can click on
/// an image to request text recognition and the system will return the recognized text.
class TextRecognitionWindow extends StatelessWidget {
  /// Creates an instance of [TextRecognitionWindow].
  const TextRecognitionWindow({
    required this.state,
    super.key,
  });

  /// A controller for this view.
  final VisionController state;

  @override
  Widget build(BuildContext context) {
    return CapabilityWindow(
      displayFormat: CapabilityWindowDisplayFormat.striped,
      title: AppLocalizations.of(context)!.visionTextRecognition,
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
                  image: VisionExampleImage.roadSign,
                  onTap: () => state.onSelectExampleImage(
                    image: VisionExampleImage.roadSign,
                    service: AppleMLVisionCapability.textRecognition,
                  ),
                  selected: state.selectedTextRecognitionExampleImage == VisionExampleImage.roadSign,
                ),
                ExampleImageTile(
                  image: VisionExampleImage.bookCover,
                  onTap: () => state.onSelectExampleImage(
                    image: VisionExampleImage.bookCover,
                    service: AppleMLVisionCapability.textRecognition,
                  ),
                  selected: state.selectedTextRecognitionExampleImage == VisionExampleImage.bookCover,
                ),
                ExampleImageTile(
                  image: VisionExampleImage.coffeeMenu,
                  onTap: () => state.onSelectExampleImage(
                    image: VisionExampleImage.coffeeMenu,
                    service: AppleMLVisionCapability.textRecognition,
                  ),
                  selected: state.selectedTextRecognitionExampleImage == VisionExampleImage.coffeeMenu,
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
                onTap: state.onRecognizeText,
                text: AppLocalizations.of(context)!.visionTextRecognitionSubmit,
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
              '${AppLocalizations.of(context)!.visionTextRecognition}: ',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          if (state.prettyPrintTextRecognition != null)
            Padding(
              padding: const EdgeInsets.only(
                top: Inset.xxSmall,
                left: Inset.medium,
                right: Inset.medium,
                bottom: Inset.xSmall,
              ),
              child: SelectableText(
                state.prettyPrintTextRecognition!,
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
