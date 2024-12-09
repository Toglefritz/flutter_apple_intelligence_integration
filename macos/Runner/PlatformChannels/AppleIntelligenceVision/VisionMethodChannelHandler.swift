import Foundation
import FlutterMacOS
import Vision
import CoreML

/// A Swift class that handles Method Channel calls for Vision ML services.
///
/// This class provides a modular interface for Apple's Vision framework and supports integration
/// with custom Core ML models. It processes calls from the Dart-side `AppleIntelligenceVisionService`
/// class and returns results back to the Flutter application.
///
/// ## Responsibilities
/// - Handles Method Channel communication for Vision ML tasks, including:
///   - Image classification
///   - Object detection
///   - Text recognition
///   - Face detection
/// - Dynamically selects between pre-trained Vision models and custom Core ML models.
///
/// ## Usage
/// - This class should be instantiated and registered in the `AppDelegate` to initialize the Method Channel.
///
/// Example in `AppDelegate.swift`:
/// ```swift
/// let visionHandler = VisionMethodChannelHandler(messenger: flutterViewController.engine.binaryMessenger)
/// ```
@available(macOS 10.15, *)
class VisionMethodChannelHandler: NSObject {
    
    /// The name of the Method Channel for Vision services.
    private static let channelName = "apple_intelligence_vision"
    
    /// The Method Channel instance for this handler.
    private let methodChannel: FlutterMethodChannel
    
    /// Initializes the Method Channel handler for Vision services.
    ///
    /// - Parameter messenger: The Flutter binary messenger for setting up the Method Channel.
    init(messenger: FlutterBinaryMessenger) {
        methodChannel = FlutterMethodChannel(name: VisionMethodChannelHandler.channelName, binaryMessenger: messenger)
        super.init()
        methodChannel.setMethodCallHandler(handle)
    }
    
    /// Handles Method Channel calls from the Dart side.
    ///
    /// - Parameters:
    ///   - call: The method call object containing the method name and arguments.
    ///   - result: A callback used to send the response back to Flutter.
    private func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let imagePath = args["imagePath"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing or invalid arguments", details: nil))
            return
        }
        
        switch call.method {
        case "classifyImage":
            result(classifyImage(at: imagePath))
            
        case "classifyImageWithCustomModel":
            guard let modelName = args["modelName"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Custom model name missing", details: nil))
                return
            }
            result(classifyImageWithCustomModel(at: imagePath, modelName: modelName))
            
        case "detectObjects":
            result(detectObjects(at: imagePath))
            
        case "detectObjectsWithCustomModel":
            guard let modelName = args["modelName"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Custom model name missing", details: nil))
                return
            }
            result(detectObjectsWithCustomModel(at: imagePath, modelName: modelName))
            
        case "recognizeText":
            result(recognizeText(at: imagePath))
            
        case "detectFaces":
            result(detectFaces(at: imagePath))
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    /// Classifies an image using the built-in Vision model.
    ///
    /// ### Overview
    /// This function performs image classification using Apple's Vision framework and Core ML.
    /// It utilizes the pre-trained MobileNetV2 model, available from Apple's model garden,
    /// to analyze the contents of an image and return a classification result with confidence scores.
    ///
    /// Image classification involves identifying the most likely category (or label) that describes the
    /// contents of an image. For example, an image of a cat might be classified as "Cat" with a
    /// confidence score of 95%.
    ///
    /// ### Model Information
    /// The function uses the MobileNetV2 model, which is optimized for on-device image classification tasks.
    /// This model is compact, efficient, and suitable for real-time use cases. The MobileNetV2 model is
    /// trained on the ImageNet dataset, allowing it to classify a wide range of everyday objects.
    ///
    /// #### Substituting the Model
    /// To substitute MobileNetV2 with a different model:
    /// 1. Download or create a Core ML-compatible model (`.mlmodel`).
    /// 2. Add the model to your Xcode project by dragging it into the project navigator.
    /// 3. Replace the `MobileNetV2` initializer in the function with the corresponding initializer for the new model.
    ///
    /// ### Result Format
    /// The function returns the classification result in the format:
    /// ```
    /// "<Label> (<Confidence>%)"
    /// ```
    /// - **Label**: The name of the category assigned to the image (e.g., "Cat").
    /// - **Confidence**: The likelihood of the label being correct, expressed as a percentage (e.g., 95%).
    ///
    /// #### Example Result
    /// For an image of a dog, the function might return:
    /// ```
    /// "Dog (87.5%)"
    /// ```
    ///
    /// ### Parameters
    /// - `imagePath`: The file path of the image to classify. This must be a valid, accessible path on the device.
    ///
    /// ### Return Value
    /// - A `String` containing the classification result (label and confidence percentage).
    /// - Returns `nil` if the classification process fails due to errors or invalid input.
    ///
    /// ### Error Handling
    /// - If the image cannot be loaded, an error message is printed, and `nil` is returned.
    /// - If the model cannot be initialized, an error message is printed, and `nil` is returned.
    /// - If no classification results are found, a fallback error message is printed, and `nil` is returned.
    private func classifyImage(at imagePath: String) -> [[String: Any]]? {
        // Ensure the image exists at the specified path
        let imageURL = URL(fileURLWithPath: imagePath)
        guard let ciImage = CIImage(contentsOf: imageURL) else {
            print("Error: Unable to load image from the provided path: \(imagePath)")
            
            return nil
        }

        // Load the Core ML model with a default configuration
        let configuration = MLModelConfiguration()
        guard let mobileNetV2 = try? MobileNetV2(configuration: configuration) else {
            print("Error: Unable to initialize MobileNetV2 with the given configuration.")
            
            return nil
        }

        // Create a Vision Core ML model
        guard let mlModel = try? VNCoreMLModel(for: mobileNetV2.model) else {
            print("Error: Unable to load the Vision model.")
            
            return nil
        }

        // Variable to store the classification results
        var classificationResults: [[String: Any]] = []

        // Create a classification request
        let request = VNCoreMLRequest(model: mlModel) { request, error in
            if let error = error {
                print("Error during image classification: \(error.localizedDescription)")
                
                return
            }
            guard let results = request.results as? [VNClassificationObservation] else {
                print("Error: No classification results found.")
                
                return
            }

            // Populate the classification results
            classificationResults = results.map { observation in
                [
                    "identifier": observation.identifier,
                    "confidence": observation.confidence
                ]
            }
        }

        // Perform the image classification request
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("Error performing image classification: \(error.localizedDescription)")
            
            return nil
        }

        // Return the classification results
        return classificationResults
    }
    
    /// Classifies an image using a custom Core ML model.
    ///
    /// - Parameters:
    ///   - imagePath: The file path of the image to classify.
    ///   - modelName: The name of the custom Core ML model.
    /// - Returns: A `String` containing the classification result or `nil` if classification fails.
    private func classifyImageWithCustomModel(at imagePath: String, modelName: String) -> String? {
        // Implementation for image classification using a custom Core ML model
        return "Placeholder: Classification result from custom model"
    }
    
    /// Detects objects in an image using the built-in Vision model.
    ///
    /// - Parameter imagePath: The file path of the image for object detection.
    /// - Returns: An array of dictionaries, where each dictionary contains:
    ///   - "object": The label of the detected object.
    ///   - "boundingBox": The bounding box of the object as an array [x, y, width, height].
    private func detectObjects(at imagePath: String) -> [[String: Any]] {
        // Ensure the image exists at the specified path
        let imageURL = URL(fileURLWithPath: imagePath)
        guard let ciImage = CIImage(contentsOf: imageURL) else {
            print("Error: Unable to load image from the provided path: \(imagePath)")
            return []
        }

        // Load the Core ML model for object detection
        let configuration = MLModelConfiguration()
        guard let objectDetectionModel = try? VNCoreMLModel(for: YOLOv3(configuration: configuration).model) else {
            print("Error: Unable to initialize object detection model.")
            return []
        }

        // Variable to store the detection results
        var detectedObjects: [[String: Any]] = []

        // Create a Vision Core ML request
        let request = VNCoreMLRequest(model: objectDetectionModel) { request, error in
            if let error = error {
                print("Error during object detection: \(error.localizedDescription)")
                return
            }

            // Parse the results
            guard let results = request.results as? [VNRecognizedObjectObservation] else {
                print("Error: No object detection results found.")
                return
            }

            // Map the results to the expected format
            detectedObjects = results.map { observation in
                let label = observation.labels.first?.identifier ?? "Unknown"
                let boundingBox = observation.boundingBox

                // Convert bounding box to an array format [x, y, width, height]
                let bboxArray = [
                    boundingBox.origin.x,
                    boundingBox.origin.y,
                    boundingBox.size.width,
                    boundingBox.size.height
                ]

                return [
                    "object": label,
                    "boundingBox": bboxArray
                ]
            }
        }

        // Perform the object detection request
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("Error performing object detection: \(error.localizedDescription)")
            return []
        }

        return detectedObjects
    }
    
    /// Detects objects in an image using a custom Core ML model.
    ///
    /// - Parameters:
    ///   - imagePath: The file path of the image for object detection.
    ///   - modelName: The name of the custom Core ML model.
    /// - Returns: An array of dictionaries with detected objects and their bounding boxes.
    private func detectObjectsWithCustomModel(at imagePath: String, modelName: String) -> [[String: Any]] {
        // Implementation for object detection using a custom Core ML model
        return [["object": "CustomModelObject", "boundingBox": [0, 0, 1, 1]]]
    }
    
    /// Recognizes text in an image.
    ///
    /// - Parameter imagePath: The file path of the image for text recognition.
    /// - Returns: A `String` containing the recognized text or `nil` if recognition fails.
    private func recognizeText(at imagePath: String) -> String? {
        // Implementation for text recognition using Vision framework
        return "Placeholder: Recognized text"
    }
    
    /// Detects faces in an image.
    ///
    /// - Parameter imagePath: The file path of the image for face detection.
    /// - Returns: An array of dictionaries with detected faces and their bounding boxes.
    private func detectFaces(at imagePath: String) -> [[String: Any]] {
        // Implementation for face detection using Vision framework
        return [["face": "PlaceholderFace", "boundingBox": [0, 0, 1, 1]]]
    }
}
