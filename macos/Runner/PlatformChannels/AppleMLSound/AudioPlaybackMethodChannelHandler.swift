import Cocoa
import AVFoundation
import FlutterMacOS

/// A Swift class that handles Method Channel calls for audio playback operations and provides playback status via an Event Channel.
///
/// This class facilitates communication between Flutter and the native macOS platform for audio playback. It allows the Flutter side to
/// send playback commands (play, pause, stop) and receive playback status updates (e.g., started, paused, completed) via an Event Channel.
class AudioPlaybackMethodChannelHandler: NSObject, AVAudioPlayerDelegate, FlutterStreamHandler {
    
    /// The name of the Method Channel for audio playback operations.
    ///
    /// This channel handles method calls such as `playAudioFile`, `pauseAudio`, and `stopAudio`.
    private static let channelName = "audio_playback"
    
    /// The name of the Event Channel for playback status updates.
    ///
    /// This channel is used to send real-time playback status updates (e.g., "started", "paused", "completed") to the Flutter app.
    private static let eventChannelName = "audio_playback_events"
    
    /// The Method Channel instance for handling playback commands.
    ///
    /// This channel is initialized with the Flutter binary messenger and is used to receive playback-related requests from the Flutter side.
    private let methodChannel: FlutterMethodChannel
    
    /// The Event Channel instance for sending playback status updates.
    ///
    /// This channel is initialized with the Flutter binary messenger and is used to send real-time playback status updates to the Flutter side.
    private let eventChannel: FlutterEventChannel
    
    /// The audio player for handling playback operations.
    ///
    /// This instance of `AVAudioPlayer` is used to play, pause, and stop audio files.
    private var audioPlayer: AVAudioPlayer?
    
    /// The event sink for sending playback status updates to the Flutter side.
    ///
    /// This sink is provided by the Event Channel when a Flutter listener subscribes to the playback events.
    private var eventSink: FlutterEventSink?
    
    /// Initializes the Method Channel and Event Channel for audio playback.
    ///
    /// - Parameter messenger: The Flutter binary messenger used to set up the channels.
    init(messenger: FlutterBinaryMessenger) {
        methodChannel = FlutterMethodChannel(name: AudioPlaybackMethodChannelHandler.channelName, binaryMessenger: messenger)
        eventChannel = FlutterEventChannel(name: AudioPlaybackMethodChannelHandler.eventChannelName, binaryMessenger: messenger)
        super.init()
        
        methodChannel.setMethodCallHandler(handle)
        eventChannel.setStreamHandler(self)
    }
    
    /// Handles Method Channel calls from the Flutter side.
    ///
    /// This function processes playback commands (e.g., play, pause, stop) received from the Flutter app and delegates them to the appropriate methods.
    ///
    /// - Parameters:
    ///   - call: The method call object containing the method name and arguments.
    ///   - result: A callback used to send the response back to Flutter.
    private func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "playAudioFile":
            guard let args = call.arguments as? [String: Any],
                  let filePath = args["filePath"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing or invalid arguments", details: nil))
                return
            }
            playAudioFile(at: filePath, result: result)
            
        case "pauseAudio":
            pauseAudio(result: result)
            
        case "stopAudio":
            stopAudio(result: result)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    /// Plays an audio file located at the specified path.
    ///
    /// - Parameters:
    ///   - filePath: The absolute file path of the audio file to play.
    ///   - result: A callback to indicate success or report an error.
    private func playAudioFile(at filePath: String, result: @escaping FlutterResult) {
        let fileURL = URL(fileURLWithPath: filePath)
        
        // Ensure the file exists at the provided path
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            result(FlutterError(code: "FILE_NOT_FOUND", message: "Audio file not found at path: \(filePath)", details: nil))
            return
        }
        
        do {
            // Initialize the AVAudioPlayer
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            
            // Start playback
            audioPlayer?.play()
            result("Playback started successfully")
            
            // Send event for playback started
            eventSink?([
                "status": "started",
                "filePath": filePath
            ])
        } catch {
            result(FlutterError(code: "PLAYBACK_ERROR", message: "Failed to play the audio file: \(error.localizedDescription)", details: nil))
        }
    }
    
    /// Pauses the currently playing audio.
    ///
    /// - Parameter result: A callback to confirm the pause action or report an error if no audio is playing.
    private func pauseAudio(result: @escaping FlutterResult) {
        guard let audioPlayer = audioPlayer, audioPlayer.isPlaying else {
            result(FlutterError(code: "NO_ACTIVE_PLAYBACK", message: "No audio is currently playing.", details: nil))
            return
        }
        audioPlayer.pause()
        result("Playback paused successfully")
        
        // Send event for playback paused
        eventSink?([
            "status": "paused"
        ])
    }
    
    /// Stops the currently playing audio.
    ///
    /// - Parameter result: A callback to confirm the stop action or report an error if no audio is playing.
    private func stopAudio(result: @escaping FlutterResult) {
        guard let audioPlayer = audioPlayer else {
            result(FlutterError(code: "NO_ACTIVE_PLAYBACK", message: "No audio is currently playing.", details: nil))
            return
        }
        audioPlayer.stop()
        self.audioPlayer = nil
        result("Playback stopped successfully")
        
        // Send event for playback stopped
        eventSink?([
            "status": "stopped"
        ])
    }
    
    // MARK: - AVAudioPlayerDelegate
    
    /// Notifies the Flutter side when the audio playback finishes.
    ///
    /// This delegate method is called automatically when the `AVAudioPlayer` completes playback.
    ///
    /// - Parameters:
    ///   - player: The audio player that finished playing.
    ///   - flag: A Boolean indicating whether the playback was successful.
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // Notify Flutter about playback completion
        eventSink?([
            "status": "completed"
        ])
    }
    
    // MARK: - FlutterStreamHandler
    
    /// Called when a Flutter listener subscribes to the Event Channel.
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }
    
    /// Called when a Flutter listener cancels their subscription to the Event Channel.
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil
    }
}
