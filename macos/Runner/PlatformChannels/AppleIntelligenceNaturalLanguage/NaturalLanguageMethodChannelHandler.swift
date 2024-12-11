import Foundation
import FlutterMacOS
import NaturalLanguage
import CoreML

/// A Swift class that handles Method Channel calls for natural language processing (NLP) services.
///
/// This class provides a modular interface for the Apple ML Natural Language (NLP) framework
/// and integrates with Core ML for custom model support. It processes calls from the Dart-side
/// `AppleMLNaturalLanguageService` class and returns results back to the Flutter application.
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
    private static let channelName = "apple_ml_nlp"
    
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
    
    /// Identifies the dominant language of the given text using the built-in Apple Core ML model.
    ///
    /// This method uses the `NLLanguageRecognizer` from Apple's Natural Language framework to determine
    /// the primary language of the input text. The recognition process analyzes linguistic patterns and
    /// returns the dominant language as a BCP 47 language tag (e.g., "en" for English, "fr" for French).
    ///
    /// - Parameter text: The input text to analyze.
    /// - Returns: A `String` containing the language code (e.g., "en") or `nil` if the language could not be identified.
    private func identifyLanguage(for text: String) -> String? {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(text)
        
        return recognizer.dominantLanguage?.rawValue
    }
    
    /// Identifies the dominant language of the given text using a custom Core ML model.
    ///
    /// This method is intended to support language identification using a developer-provided Core ML model.
    /// The custom model is expected to handle language detection and output a compatible language code.
    ///
    /// - Parameters:
    ///   - text: The input text to analyze.
    ///   - modelName: The name of the custom Core ML model to use for language identification.
    /// - Returns: A `String` containing the language code (e.g., "en") or `nil` if the language could not be identified.
    private func identifyLanguageWithCustomModel(for text: String, modelName: String) -> String? {
        // Load and use the custom Core ML model
        return nil // Placeholder for custom implementation
    }
    
    /// Analyzes the sentiment of the given text using the built-in Apple Core ML model.
    ///
    /// Sentiment analysis evaluates the emotional tone conveyed in the input text, assigning a numerical
    /// score to indicate the sentiment. The score ranges from -1.0 (strongly negative) to 1.0 (strongly positive),
    /// with 0.0 representing neutral sentiment. This method uses the built-in sentiment model from the
    /// `NLTagger` class.
    ///
    /// - Parameter text: The input text to analyze.
    /// - Returns: A `Double` representing the sentiment score or `nil` if sentiment analysis fails.
    private func analyzeSentiment(for text: String) -> Double? {
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = text
        
        return tagger.tag(at: text.startIndex, unit: .paragraph, scheme: .sentimentScore).0.flatMap { Double($0.rawValue) }
    }
    
    /// Analyzes the sentiment of the given text using a custom Core ML model.
    ///
    /// This method is intended for sentiment analysis using a developer-provided Core ML model. The custom model
    /// should be designed to output a sentiment score in the range of -1.0 to 1.0.
    ///
    /// - Parameters:
    ///   - text: The input text to analyze.
    ///   - modelName: The name of the custom Core ML model to use for sentiment analysis.
    /// - Returns: A `Double` representing the sentiment score or `nil` if the analysis fails.
    private func analyzeSentimentWithCustomModel(for text: String, modelName: String) -> Double? {
        // Load and use the custom Core ML model
        return nil // Placeholder for custom implementation
    }
    
    /// Tokenizes the input text into smaller components such as words or sentences.
    ///
    /// This method uses the `NLTokenizer` class to segment the text into tokens based on the specified unit:
    /// - `"word"`: Divides the text into individual words and punctuation.
    /// - `"sentence"`: Divides the text into complete sentences.
    ///
    /// Tokenization is a foundational NLP operation used in text preprocessing, enabling downstream tasks
    /// like sentiment analysis or entity recognition.
    ///
    /// - Parameters:
    ///   - text: The input text to tokenize.
    ///   - unit: The level of tokenization ("word" or "sentence").
    /// - Returns: An array of `String` tokens extracted from the input text.
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
    
    /// Recognizes named entities in the input text and classifies them into predefined categories.
    ///
    /// Named Entity Recognition (NER) identifies specific entities within the text, such as:
    /// - `"PersonalName"`: Names of people.
    /// - `"PlaceName"`: Geographic locations.
    /// - `"OrganizationName"`: Names of organizations.
    ///
    /// This method uses the `NLTagger` class with the `.nameType` scheme to perform entity recognition.
    ///
    /// - Parameter text: The input text to analyze for named entities.
    /// - Returns: An array of dictionaries, where each dictionary contains:
    ///   - `"entity"`: The identified entity (e.g., "John").
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
    
    /// Lemmatizes the input text by reducing words to their base or dictionary form.
    ///
    /// Lemmatization normalizes words by removing inflections while retaining the grammatical context.
    /// For example:
    /// - `"running"` → `"run"`
    /// - `"better"` → `"good"`
    ///
    /// This method uses the `NLTagger` class with the `.lemma` scheme to extract the base forms of words.
    ///
    /// - Parameter text: The input text to lemmatize.
    /// - Returns: An array of `String` containing the lemmatized words from the input text.
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
