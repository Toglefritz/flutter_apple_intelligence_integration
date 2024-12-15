import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/playback_status.dart';

/// A service class for handling audio playback operations in a Flutter application.
///
/// This class provides methods to control audio playback, including playing an audio file, pausing playback, and
/// stopping playback. It communicates with the native platform using a Method Channel named `audio_playback` and
/// provides playback status updates via an Event Channel named `audio_playback_events`.
class AudioPlaybackService {
  /// The Method Channel used for communication with the native platform.
  ///
  /// This channel is registered with the name `audio_playback` and is used to send audio playback requests from the
  /// Flutter side to the native platform (e.g., macOS or iOS).
  static const MethodChannel _channel = MethodChannel('audio_playback');

  /// The Event Channel used for listening to playback status updates from the native platform.
  ///
  /// This channel is registered with the name `audio_playback_events` and is used to receive real-time playback status
  /// updates, such as "started", "paused", "completed", etc.
  static const EventChannel _eventChannel = EventChannel('audio_playback_events');

  /// A stream for receiving playback status updates.
  ///
  /// The stream emits [PlaybackStatus] values corresponding to the playback status updates
  /// ("started", "paused", "stopped", or "completed").
  Stream<PlaybackStatus> get playbackStatusStream {
    return _eventChannel.receiveBroadcastStream().map((event) {
      // Safely parse the "status" from the event and map it to PlaybackStatus.
      final Map<dynamic, dynamic> eventData = event as Map<dynamic, dynamic>;
      final String? status = eventData['status'] as String?;

      return PlaybackStatus.fromString(status);
    });
  }

  /// Plays an audio file located at the specified path.
  ///
  /// This method sends a request to the native platform to play an audio file at the specified `filePath`. The file
  /// must be accessible on the device, and the path should be an absolute file path.
  ///
  /// - [filePath]: A string representing the absolute path to the audio file.
  ///
  /// ## Example
  /// ```dart
  /// final audioService = AudioPlaybackService();
  /// await audioService.playAudioFile('/path/to/audio.mp3');
  /// ```
  Future<void> playAudioFile(String filePath) async {
    try {
      final String result = await _channel.invokeMethod('playAudioFile', {'filePath': filePath}) as String;
      debugPrint(result); // Outputs: "Playback started successfully"
    } catch (e) {
      debugPrint('Playing audio file failed with exception: $e');
    }
  }

  /// Pauses the currently playing audio.
  ///
  /// This method sends a request to the native platform to pause the audio that is currently being played. If no audio
  /// is playing, the request will fail, and an error will be logged.
  ///
  /// ## Example
  /// ```dart
  /// final audioService = AudioPlaybackService();
  /// await audioService.pauseAudio();
  /// ```
  Future<void> pauseAudio() async {
    try {
      final String result = await _channel.invokeMethod('pauseAudio') as String;
      debugPrint(result); // Outputs: "Playback paused successfully"
    } catch (e) {
      debugPrint('Error pausing audio playback: $e');
    }
  }

  /// Stops the currently playing audio.
  ///
  /// This method sends a request to the native platform to stop the audio playback. If no audio is currently being
  /// played, the request will fail, and an error will be logged.
  ///
  /// ## Example
  /// ```dart
  /// final audioService = AudioPlaybackService();
  /// await audioService.stopAudio();
  /// ```
  Future<void> stopAudio() async {
    try {
      final String result = await _channel.invokeMethod('stopAudio') as String;
      debugPrint(result); // Outputs: "Playback stopped successfully"
    } catch (e) {
      debugPrint('Error stopping audio playback: $e');
    }
  }
}
