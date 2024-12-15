import 'package:demo_app/screens/components/brutalist_button.dart';
import 'package:demo_app/screens/components/capability_window.dart';
import 'package:demo_app/screens/sound/components/example_sound_tile.dart';
import 'package:demo_app/screens/sound/sound_controller.dart';
import 'package:demo_app/services/apple_ml_sound/models/sound_example_file.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// A "window" containing a series of example sound files for which the user can request classification
///
/// This widget presents a "window" designed to look like it is from a 1980s computer interface. The window includes a
/// selection of sound files that can be submitted for classification using Apple Machine Learning. The user can click
/// on a sound file card to request classification and the system will return list of classification results.
/// Additionally, the user can preview the sound file by clicking on the play button.
class SoundFileClassificationWindow extends StatelessWidget {
  /// Creates an instance of [SoundFileClassificationWindow].
  const SoundFileClassificationWindow({
    required this.state,
    super.key,
  });

  /// A controller for this view.
  final SoundController state;

  @override
  Widget build(BuildContext context) {
    return CapabilityWindow(
      displayFormat: CapabilityWindowDisplayFormat.striped,
      title: AppLocalizations.of(context)!.soundFileClassification,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: Inset.medium,
              bottom: Inset.small,
            ),
            child: Text(
              AppLocalizations.of(context)!.soundSelectExampleSoundFile,
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
              children: List.generate(
                SoundExampleFile.values.length,
                (int index) {
                  final SoundExampleFile sound = SoundExampleFile.values[index];

                  return ExampleSoundTile(
                    sound: sound,
                    onTap: () => state.onSelectExampleSoundFile(sound: sound),
                    selected: state.selectedSoundExampleFile == sound,
                    onPlay: () => state.onPlaySoundFile(sound),
                    onStop: state.onStopSoundFile,
                    playingSoundFile: state.playingSoundExampleFile,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: Inset.small,
              bottom: Inset.xSmall,
            ),
            child: Center(
              child: BrutalistButton(
                onTap: state.onClassifySoundFile,
                text: AppLocalizations.of(context)!.soundClassifySoundSubmit,
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
              '${AppLocalizations.of(context)!.soundFileClassificationSubmit}: ',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          if (state.prettyPrintClassificationResults != null)
            Padding(
              padding: const EdgeInsets.only(
                top: Inset.xxSmall,
                left: Inset.medium,
                right: Inset.medium,
                bottom: Inset.xSmall,
              ),
              child: SelectableText(
                state.prettyPrintClassificationResults!,
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
