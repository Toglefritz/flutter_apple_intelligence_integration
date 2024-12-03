import Foundation
import FlutterMacOS
import NaturalLanguage
import CoreML

/// A Swift class that handles Method Channel calls for natural language processing (NLP) services.
///
/// This class provides a modular interface for the Apple Intelligence Natural Language (NLP) framework
/// and integrates with Core ML for custom model support. It processes calls from the Dart-side
/// `AppleIntelligenceNaturalLanguageService` class and returns results back to the Flutter application.
///
/// ## Responsibilities
/// - Handles Method Channel communication for NLP tasks, including:
///   - Language identification
///   - Sentiment analysis
///   - Tokenization
///   - Named Entity Recognition (NER)
///   - Lemmatization
/// - Dynamically selects between the pre-trained NLP models and custom Core ML models based on
///   the input parameters.
///
/// ## Usage
/// - This class should be instantiated and registered in the `AppDelegate` to initialize the Method Channel.
///
/// Example in `AppDelegate.swift`:
/// ```swift
/// let naturalLanguageHandler = NaturalLanguageMethodChannelHandler(messenger: flutterViewController.engine.binaryMessenger)
/// ```
///
@available(macOS 10.15, *)
class NaturalLanguageMethodChannelHandler: NSObject {
    
    /// The name of the Method Channel for communicating with the Dart side.
    private static let channelName = "apple_intelligence_nlp"
    
    /// The Method Channel instance for this handler.
    private let methodChannel: FlutterMethodChannel
    
    /// Initializes the Method Channel handler for NLP services.
    ///
    /// - Parameter messenger: The Flutter binary messenger for setting up the Method Channel.
    init(messenger: FlutterBinaryMessenger) {
        methodChannel = FlutterMethodChannel(name: NaturalLanguageMethodChannelHandler.channelName, binaryMessenger: messenger)
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
              let text = args["text"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing or invalid arguments", details: nil))
            return
        }
        
        switch call.method {
        case "identifyLanguage":
            result(identifyLanguage(for: text))
            
        case "identifyLanguageWithCustomModel":
            guard let modelName = args["modelName"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Custom model name missing", details: nil))
                return
            }
            result(identifyLanguageWithCustomModel(for: text, modelName: modelName))
            
        case "analyzeSentiment":
            result(analyzeSentiment(for: text))
            
        case "analyzeSentimentWithCustomModel":
            guard let modelName = args["modelName"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Custom model name missing", details: nil))
                return
            }
            result(analyzeSentimentWithCustomModel(for: text, modelName: modelName))
            
        case "tokenize":
            guard let unit = args["unit"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Tokenization unit missing", details: nil))
                return
            }
            result(tokenize(text: text, unit: unit))
            
        case "recognizeEntities":
            result(recognizeEntities(for: text))
            
        case "lemmatize":
            result(lemmatize(for: text))
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    /// Identifies the language of the given text using the pre-trained model.
    private func identifyLanguage(for text: String) -> String? {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(text)
        
        return recognizer.dominantLanguage?.rawValue
    }
    
    /// Identifies the language of the given text using a custom Core ML model.
    private func identifyLanguageWithCustomModel(for text: String, modelName: String) -> String? {
        // Load and use the custom Core ML model
        return nil // Placeholder for custom implementation
    }
    
    /// Analyzes the sentiment of the given text using the pre-trained model.
    private func analyzeSentiment(for text: String) -> Double? {
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = text
        
        return tagger.tag(at: text.startIndex, unit: .paragraph, scheme: .sentimentScore).0.flatMap { Double($0.rawValue) }
    }
    
    /// Analyzes the sentiment of the given text using a custom Core ML model.
    private func analyzeSentimentWithCustomModel(for text: String, modelName: String) -> Double? {
        // Load and use the custom Core ML model
        return nil // Placeholder for custom implementation
    }
    
    /// Tokenizes the input text into words or sentences.
    private func tokenize(text: String, unit: String) -> [String] {
        // Determine the correct tokenization unit based on the `unit` argument
        let tokenizer: NLTokenizer

        if unit.lowercased() == "sentence" {
            tokenizer = NLTokenizer(unit: .sentence)
        } else {
            // Default to word-level tokenization if "sentence" is not specified
            tokenizer = NLTokenizer(unit: .word)
        }

        tokenizer.string = text

        // Extract tokens and return them as an array of strings
        return tokenizer.tokens(for: text.startIndex..<text.endIndex).map { String(text[$0]) }
    }
    
    /// Recognizes named entities in the input text.
    private func recognizeEntities(for text: String) -> [[String: String]] {
        let tagger = NLTagger(tagSchemes: [.nameType])
        tagger.string = text
        var entities: [[String: String]] = []
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .nameType, options: []) { tag, tokenRange in
            if let tag = tag {
                entities.append(["entity": String(text[tokenRange]), "type": tag.rawValue])
            }
            
            return true
        }
        
        return entities
    }
    
    /// Lemmatizes the input text.
    private func lemmatize(for text: String) -> [String] {
        let tagger = NLTagger(tagSchemes: [.lemma])
        tagger.string = text
        var lemmas: [String] = []
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lemma, options: []) { tag, _ in
            if let lemma = tag?.rawValue {
                lemmas.append(lemma)
            }
            
            return true
        }
        
        return lemmas
    }
}
