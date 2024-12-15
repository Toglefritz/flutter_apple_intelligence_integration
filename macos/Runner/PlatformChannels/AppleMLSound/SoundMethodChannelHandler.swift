import Foundation
import FlutterMacOS
import SoundAnalysis

/// A Swift class that handles Method Channel calls for sound classification.
///
/// This class uses Apple's Sound Analysis framework to perform sound classification
/// tasks and streams the classification results to Flutter via an Event Channel.
@available(macOS 12.0, *)
class SoundMethodChannelHandler: NSObject {
    
    /// The name of the Method Channel for sound classification.
    private static let channelName = "apple_ml_sound"
    
    /// The Method Channel instance for this handler.
    private let methodChannel: FlutterMethodChannel
    
    /// The Event Channel for streaming sound classification results.
    private let eventChannel: FlutterEventChannel
    
    /// The EventSink for sending sound classification results to Flutter.
    private var eventSink: FlutterEventSink?
    
    /// Initializes the Method Channel handler for sound classification.
    ///
    /// - Parameter messenger: The Flutter binary messenger for setting up the channels.
    @available(macOS 12.0, *)
    init(messenger: FlutterBinaryMessenger) {
        methodChannel = FlutterMethodChannel(name: SoundMethodChannelHandler.channelName, binaryMessenger: messenger)
        eventChannel = FlutterEventChannel(name: "apple_ml_sound_events", binaryMessenger: messenger)
        super.init()
        methodChannel.setMethodCallHandler(handle)
    }
    
    /// Handles Method Channel calls from the Flutter side.
    ///
    /// - Parameters:
    ///   - call: The method call object containing the method name and arguments.
    ///   - result: A callback used to send the response back to Flutter.
    @available(macOS 12.0, *)
    private func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "classifySoundFile":
            guard let args = call.arguments as? [String: Any],
                  let filePath = args["filePath"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing or invalid arguments", details: nil))
                return
            }
            classifySoundFile(at: filePath, result: result)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    /// Classifies sound from an input audio file.
    ///
    /// This method processes the input audio file and performs sound classification using a pre-trained classifier.
    ///
    /// - Parameters:
    ///   - filePath: The file path of the audio file to classify.
    ///   - result: A callback used to send the classification results back to Flutter.
    private func classifySoundFile(at filePath: String, result: @escaping FlutterResult) {
        let fileURL = URL(fileURLWithPath: filePath)
        
        // Ensure the file exists at the provided path
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            result(FlutterError(code: "FILE_NOT_FOUND", message: "Audio file not found at path: \(filePath)", details: nil))
            return
        }
        
        // Create a sound classification request
        guard let classifyRequest = try? SNClassifySoundRequest(classifierIdentifier: SNClassifierIdentifier.version1) else {
            result(FlutterError(code: "REQUEST_ERROR", message: "Failed to create sound classification request.", details: nil))
            return
        }
        
        // Analyze the audio file
        do {
            let audioFileAnalyzer = try SNAudioFileAnalyzer(url: fileURL)
            let observer = SoundClassificationObserver(resultCallback: result)
            
            try audioFileAnalyzer.add(classifyRequest, withObserver: observer)
            
            // Start processing the audio file
            audioFileAnalyzer.analyze()
        } catch {
            result(FlutterError(code: "ANALYSIS_ERROR", message: "Failed to analyze the audio file: \(error.localizedDescription)", details: nil))
        }
    }
}

/// A class to observe sound classification results and send them to Flutter.
@available(macOS 10.15, *)
class SoundClassificationObserver: NSObject, SNResultsObserving {
    
    /// Callback for sending classification results back to Flutter.
    private let resultCallback: FlutterResult
    
    /// Tracks whether the resultCallback has been called.
    private var hasResponded = false
    
    /// Initializes the observer with the result callback.
    ///
    /// - Parameter resultCallback: The callback to send results to Flutter.
    init(resultCallback: @escaping FlutterResult) {
        self.resultCallback = resultCallback
    }
    
    /// Processes the results of sound classification.
    ///
    /// - Parameters:
    ///   - request: The sound classification request that generated the results.
    ///   - result: The results of the sound classification request.
    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let classificationResult = result as? SNClassificationResult else { return }
        
        let classifications = classificationResult.classifications.map { classification in
            return [
                "identifier": classification.identifier,
                "confidence": classification.confidence
            ]
        }
        
        if !hasResponded {
            resultCallback(classifications)
            hasResponded = true
        }
    }
    
    /// Handles errors during sound classification.
    ///
    /// - Parameters:
    ///   - request: The sound classification request that generated the error.
    ///   - error: The error that occurred during processing.
    func request(_ request: SNRequest, didFailWithError error: Error) {
        if !hasResponded {
            resultCallback(FlutterError(code: "CLASSIFICATION_ERROR", message: error.localizedDescription, details: nil))
            hasResponded = true
        }
    }
    
    /// Handles the completion of sound classification processing.
    ///
    /// - Parameter request: The sound classification request that completed processing.
    func requestDidComplete(_ request: SNRequest) {
        // Optional: Notify Flutter of completion if needed
        if !hasResponded {
            resultCallback([])
            hasResponded = true
        }
    }
}
