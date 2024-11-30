# Flutter Apple Intelligence Integration Example

## Purpose

This project serves as a demonstration and template for integrating Apple Intelligence features into
a Flutter application. It showcases how to use Dart services and Swift Method Channel handlers to
access native iOS capabilities offered by Apple’s suite of machine learning (ML) frameworks,
including:

- **Core ML**: Utilize on-device machine learning models for predictions and classifications.
- **Vision**: Perform image analysis and computer vision tasks like object detection.
- **Natural Language**: Process and analyze text for tasks like tokenization, sentiment analysis,
  and language identification.
- **Speech**: Implement speech-to-text transcription.
- **Sound Analysis**: Classify and detect sounds from audio input.
- **Translation**: Translate text between languages.

The project is designed for developers who want to directly integrate Apple’s native ML frameworks
into their Flutter applications without relying on third-party plugins. It provides a modular
approach where you can choose only the features you need, making it easy to avoid extraneous
infrastructure and keep your codebase clean.

## Key Features

- **Customizable Services**: Each service class (e.g., `AppleIntelligenceVisionService`) can be
  instantiated to use either the default pre-trained models or custom Core ML models.
- **Dynamic Model Selection**: Methods within the service classes dynamically select between
  built-in models and custom models, giving preference to the provided custom Core ML model if
  available.
- **Modular Design**: Each Apple Intelligence capability is encapsulated in a pair of Dart and Swift
  files.
- **Reusable Dart Services**: Dart classes handle Method Channel communication with the native iOS
  platform.
- **Customizable Swift Handlers**: Swift classes process method calls from Dart and interact with
  Apple’s native APIs.
- **Ease of Integration**: Developers can copy the Dart service and Swift handler pair corresponding
  to the desired feature into their own Flutter projects.

## Project Structure

**Dart Side**
Each Apple Intelligence feature is represented by a Dart service class, which communicates with the
corresponding native Swift handler using a dedicated Method Channel.

```text
lib/
├── services/
│   ├── apple_intelligence_vision_service.dart      # Vision framework integration
│   ├── apple_intelligence_natural_language_service.dart # Natural Language framework integration
│   ├── apple_intelligence_speech_service.dart      # Speech recognition integration
│   ├── apple_intelligence_sound_analysis_service.dart # Sound Analysis framework integration
│   └── apple_intelligence_translation_service.dart # Translation framework integration
├── main.dart
```

**Swift Side**
On the iOS/macOS side, each feature has a dedicated Method Channel handler written in Swift. These
handlers process the method calls from Dart, interact with the appropriate Apple framework, and
return results back to the Flutter app.

```text
ios/
└── Runner/
    ├── PlatformChannels/
    │   ├── Vision/
    │   │   └── VisionMethodChannelHandler.swift
    │   ├── NaturalLanguage/
    │   │   └── NaturalLanguageMethodChannelHandler.swift
    │   ├── Speech/
    │   │   └── SpeechMethodChannelHandler.swift
    │   ├── SoundAnalysis/
    │   │   └── SoundAnalysisMethodChannelHandler.swift
    │   └── Translation/
    │       └── TranslationMethodChannelHandler.swift
    └── AppDelegate.swift
```

## Using Custom Models with Core ML

Each service class allows developers to pass a custom Core ML model during instantiation. For
example:

```dart
// Using the built-in Vision model
final AppleIntelligenceVisionService visionService = AppleIntelligenceVisionService();

// Using a custom Core ML model for Vision
final AppleIntelligenceVisionService visionServiceWithCustomModel = AppleIntelligenceVisionService
    .withCustomModel(
    'CustomVisionModelName');
```

Methods within the service class, such as `analyzeSentiment` or `classifyImage`, dynamically choose
between using the built-in model or the provided custom Core ML model.

## How to Use This Project

1. Clone the Repository:

```bash
git clone https://github.com/Toglefritz/flutter_apple_intelligence_integration.git
```

2. Choose the Features You Need:
    - Select the pairs of Dart service classes and Swift handlers corresponding to the Apple
      Intelligence features you need.
    - For example, if you want image classification:
        - Use apple_intelligence_coreml_service.dart (Dart) and CoreMLMethodChannelHandler.swift (
          Swift).

3. Integrate into Your Project:
    - Copy the Dart service class into the lib/services/ directory of your Flutter project.
    - Copy the Swift handler class into the appropriate location in your iOS project (e.g.,
      ios/Runner/PlatformChannels/).

4. Update the iOS AppDelegate:
    - Register the Method Channel handler in your app’s AppDelegate.swift file:

```swift
import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    CoreMLMethodChannelHandler.register(with: self.registrar(forPlugin: "CoreMLMethodChannelHandler")!)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

5. Test the Integration:

- Use the Dart service to make calls to the native iOS APIs and verify the results using Flutter’s
  debug tools.