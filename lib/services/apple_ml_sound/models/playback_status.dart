/// An enumeration of sound file playback status.
enum PlaybackStatus {
  /// The sound file is currently playing.
  started,

  /// The sound file is currently paused.
  paused,

  /// The sound file is currently stopped.
  stopped,

  /// The sound file playback is completed.
  completed;

  /// Returns a [PlaybackStatus] for the provided string value.
  static PlaybackStatus fromString(String? value) {
    switch (value) {
      case 'started':
        return PlaybackStatus.started;
      case 'paused':
        return PlaybackStatus.paused;
      case 'stopped':
        return PlaybackStatus.stopped;
      case 'completed':
        return PlaybackStatus.completed;
      default:
        // Return a "completed" status by default.
        return PlaybackStatus.completed;
    }
  }
}
