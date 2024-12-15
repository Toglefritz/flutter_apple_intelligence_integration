import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// A collection of sound effect files to be used for demonstrating the capabilities of the Apple Machine Learning Sound
/// Analysis service.
enum SoundExampleFile {
  /// A sound effect of crickets.
  crickets._(
    soundFile: 'assets/sound_examples/cricket_sound.mp3',
    thumbnail: 'assets/sound_examples/cricket_thumbnail.png',
  ),

  /// A sound effect of a symphony orchestra warming up and tuning.
  orchestra._(
    soundFile: 'assets/sound_examples/symphony_orchestra_tuning_sound.mp3',
    thumbnail: 'assets/sound_examples/symphony_orchestra_thumbnail.png',
  ),

  /// A sound effect of a circular saw cutting wood.
  circularSaw._(
    soundFile: 'assets/sound_examples/circular_saw_sound.mp3',
    thumbnail: 'assets/sound_examples/circular_saw_thumbnail.png',
  ),

  /// A sound effect of a dog barking.
  dogBark._(
    soundFile: 'assets/sound_examples/dog_barking_sound.mp3',
    thumbnail: 'assets/sound_examples/dog_barking_thumbnail.png',
  ),
  ;

  /// The file path of the sound effect.
  final String soundFile;

  /// The file path of a thumbnail representing the sound effect.
  final String thumbnail;

  /// Creates a new instance of [SoundExampleFile].
  const SoundExampleFile._({
    required this.soundFile,
    required this.thumbnail,
  });

  /// Returns an absolute file path for the sound file that can be accessed by the native platform.
  ///
  /// This method copies the sound file from the assets to a temporary directory and returns the path to the copy.
  /// The resulting path can be used to classify the sound using the Apple Machine Learning Sound service.
  Future<String> getAbsolutePath() async {
    // Get the temporary directory for the app
    final Directory tempDir = await getTemporaryDirectory();

    // Determine the destination path
    final String fileName = soundFile.split('/').last; // Extract the file name
    final String filePath = '${tempDir.path}/$fileName';

    // Copy the asset to the temporary directory if it doesn't already exist
    final File file = File(filePath);
    if (!file.existsSync()) {
      final ByteData byteData = await rootBundle.load(soundFile);
      await file.writeAsBytes(byteData.buffer.asUint8List());
    }

    // Return the absolute file path
    return filePath;
  }
}
