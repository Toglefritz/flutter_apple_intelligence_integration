import 'package:demo_app/screens/sound/sound_route.dart';
import 'package:demo_app/screens/sound/sound_view.dart';
import 'package:demo_app/services/apple_ml_sound/apple_ml_sound_service.dart';
import 'package:demo_app/services/apple_ml_sound/audio_playback_service.dart';
import 'package:demo_app/services/apple_ml_sound/models/playback_status.dart';
import 'package:demo_app/services/apple_ml_sound/models/sound_classification_result.dart';
import 'package:demo_app/services/apple_ml_sound/models/sound_example_file.dart';
import 'package:flutter/material.dart';

/// A controller for the [SoundRoute].
class SoundController extends State<SoundRoute> {
  /// A service for using the natural language processing capabilities of Apple Machine Learning.
  final AppleMLSoundService _soundService = AppleMLSoundService();

  /// A sound example file that is currently playing.
  SoundExampleFile? playingSoundExampleFile;

  /// The example sound file selected by the user for classification.
  SoundExampleFile? selectedSoundExampleFile;

  /// A list of objects representing the result of the sound classification on the selected sound example file.
  ///
  /// This value is set when the user requests classification of a sound file. Each item in this list is an instance of
  /// [SoundClassificationResult] containing the label and confidence score for the classification.
  List<SoundClassificationResult>? soundClassificationResult;

  /// Called when the back button is tapped.
  void onBack() {
    // Pop the current route off the navigator and go back to the HomeRoute.
    Navigator.of(context).pop();
  }

  /// Called when the user selects an example sound file for classification.
  void onSelectExampleSoundFile({
    required SoundExampleFile sound,
  }) {
    setState(() {
      selectedSoundExampleFile = sound;
    });
  }

  /// Plays the selected sound file and listens for playback status changes.
  Future<void> onPlaySoundFile(SoundExampleFile sound) async {
    // If there is already a sound file playing, do nothing.
    if (playingSoundExampleFile != null) {
      return;
    }

    setState(() {
      playingSoundExampleFile = sound;
    });

    // The AudioPlaybackService is used to play audio files.
    final AudioPlaybackService audioPlaybackService = AudioPlaybackService();

    try {
      // Get the absolute file path of the selected sound file
      final String filePath = await sound.getAbsolutePath();

      // Start playback of the sound file
      await audioPlaybackService.playAudioFile(filePath);

      debugPrint('Playback started for file at: $filePath');

      // Listen for playback status updates
      audioPlaybackService.playbackStatusStream.listen((status) {
        if (status == PlaybackStatus.completed) {
          debugPrint('Playback completed for file: $filePath');
          // Reset the playing sound file after playback is complete
          setState(() {
            playingSoundExampleFile = null;
          });
        }
      });
    } catch (e) {
      debugPrint('Failed to play sound file: $e');
      // Reset the playing sound file in case of an error
      setState(() {
        playingSoundExampleFile = null;
      });
    }
  }

  /// Stops the currently playing sound file.
  Future<void> onStopSoundFile() async {
    // If there is no sound file playing, do nothing.
    if (playingSoundExampleFile == null) {
      return;
    }

    // The AudioPlaybackService is used to stop audio playback.
    final AudioPlaybackService audioPlaybackService = AudioPlaybackService();

    try {
      // Stop the currently playing sound file
      await audioPlaybackService.stopAudio();

      debugPrint('Playback stopped');
    } catch (e) {
      debugPrint('Failed to stop sound file: $e');
    }

    setState(() {
      playingSoundExampleFile = null;
    });
  }

  /// Handles requests to classify the selected sound file.
  Future<void> onClassifySoundFile() async {
    if (selectedSoundExampleFile == null) {
      debugPrint('No example sound selected');

      return;
    }

    debugPrint('Performing sound classification on file');

    // Get the absolute file path of the selected example image
    final String imagePath = await selectedSoundExampleFile!.getAbsolutePath();

    // Use the natural language service to identify the language of the text.
    final List<SoundClassificationResult>? classification = await _soundService.classifySoundFile(imagePath);

    debugPrint(
      'Classified sound with highest confidence result, "${classification?.first.identifier}: ${classification?.first.confidence}"',
    );

    setState(() {
      soundClassificationResult = classification;
    });
  }

  /// Returns a "pretty print" string representation of the classification results.
  ///
  /// To provide a cleaner output, this function will return a string with each classification result on a new line.
  /// It will include only the top ten classification results, if available, to avoid the list becoming too long.
  String? get prettyPrintClassificationResults {
    if (soundClassificationResult == null) {
      return null;
    }

    // Sort the classification results by confidence score in descending order.
    final List<SoundClassificationResult> sortedResults =
        List<SoundClassificationResult>.from(soundClassificationResult!)
          ..sort((a, b) => b.confidence.compareTo(a.confidence));

    // Get the top ten classification results, or all results if there are fewer than ten.
    final List<SoundClassificationResult> topResults = sortedResults.take(10).toList();

    // Create a string representation of the classification results.
    final String prettyPrintedResults = topResults.map((result) {
      return '${result.identifier}: ${result.confidencePercentage}';
    }).join('\n');

    return prettyPrintedResults;
  }

  @override
  Widget build(BuildContext context) => SoundView(this);
}
