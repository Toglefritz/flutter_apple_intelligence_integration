import 'package:demo_app/extensions/string_extensions.dart';
import 'package:demo_app/services/apple_ml_sound/models/sound_example_file.dart';
import 'package:demo_app/values/inset.dart';
import 'package:flutter/material.dart';

/// A container displaying an example sound file for demonstrating Apple Machine Learning sound features.
///
/// This widget displays an example sound file that can be used to demonstrate the capabilities of the Apple ML Sound.
/// The sound can be displayed in a `selected` state. In this state, a border is drawn around the sound tile. In the
/// unselected state, no border is drawn.
///
/// The user can preview the sound file by clicking on the play button in the tile.
class ExampleSoundTile extends StatelessWidget {
  /// Creates an instance of [ExampleSoundTile].
  const ExampleSoundTile({
    required this.sound,
    required this.onTap,
    required this.selected,
    required this.onPlay,
    required this.onStop,
    required this.playingSoundFile,
    super.key,
  });

  /// The sound file displayed in this widget.
  final SoundExampleFile sound;

  /// A function called when the image is tapped.
  final void Function() onTap;

  /// Determines if the image is in a "selected" state. If `true`, a border is drawn around the image.
  final bool selected;

  /// Handles taps on the play button for the example sound file. This will trigger the sound file to play.
  final void Function() onPlay;

  /// Handles taps on the stop button for the example sound file. This will trigger the sound file to stop playing.
  final void Function() onStop;

  /// The sound example file that is currently playing.
  final SoundExampleFile? playingSoundFile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 128 + Inset.xxxSmall * 2,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
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
          child: Column(
            children: [
              Image.asset(
                sound.thumbnail,
                width: 128,
                height: 128,
              ),
              Row(
                children: [
                  // If there is no sound file playing, show a play button.
                  if (playingSoundFile == null)
                    Padding(
                      padding: const EdgeInsets.only(
                        right: Inset.xSmall,
                      ),
                      child: GestureDetector(
                        onTap: onPlay,
                        child: const Icon(
                          Icons.play_arrow_outlined,
                          size: 32,
                        ),
                      ),
                    ),
                  // If the sound file provided to this widget is currently playing, show a stop button.
                  if (playingSoundFile == sound)
                    Padding(
                      padding: const EdgeInsets.only(
                        right: Inset.xSmall,
                      ),
                      child: GestureDetector(
                        onTap: onStop,
                        child: const Icon(
                          Icons.stop_outlined,
                          size: 32,
                        ),
                      ),
                    ),
                  // If a different sound file is currently playing, show a greyed out and disabled play button.
                  if (playingSoundFile != null && playingSoundFile != sound)
                    const Padding(
                      padding: EdgeInsets.only(
                        right: Inset.xSmall,
                      ),
                      child: Icon(
                        Icons.play_arrow_outlined,
                        size: 32,
                        color: Colors.grey,
                      ),
                    ),
                  Expanded(
                    child: Text(
                      sound.name.capitalize()!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
