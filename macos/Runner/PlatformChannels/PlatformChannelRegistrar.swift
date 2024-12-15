import FlutterMacOS

/// A class responsible for registering all platform-specific Method Channel handlers.
///
/// The `PlatformChannelRegistrar` class acts as a centralized point for setting up and managing
/// platform-specific Method Channel handlers. It ensures that each feature's Method Channel logic
/// is initialized and connected to the Flutter app's binary messenger, enabling seamless communication
/// between the Dart and native macOS layers.
///
/// This class is part of a modular architecture that improves maintainability and scalability by
/// separating the responsibilities of registering and managing Method Channels from the app's main
/// entry point (`AppDelegate`). This separation of concerns simplifies the codebase and allows
/// individual Method Channel handlers to be updated or extended independently.
@available(macOS 12.0, *)
class PlatformChannelRegistrar {
    private let messenger: FlutterBinaryMessenger

    /// Initializes the registrar with a Flutter binary messenger.
    ///
    /// - Parameter messenger: The binary messenger used to set up Method Channels.
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
    }

    /// Registers all Method Channel handlers.
    func registerHandlers() {
        registerNaturalLanguageHandler()
        registerVisionHandler()
        registerSoundHandler()
        registerAudioFilePlaybackHandler()
    }

    /// Registers the Natural Language Method Channel handler.
    private func registerNaturalLanguageHandler() {
        _ = NaturalLanguageMethodChannelHandler(messenger: messenger)
    }
    
    /// Registers the Vision Method Channel handler.
    private func registerVisionHandler() {
        _ = VisionMethodChannelHandler(messenger: messenger)
    }
    
    /// Registers the Sound Method Channel handler.
    private func registerSoundHandler() {
        _ = SoundMethodChannelHandler(messenger: messenger)
    }
    
    /// Registers the audio file playback Method Channel handler.
    private func registerAudioFilePlaybackHandler() {
        _ = AudioPlaybackMethodChannelHandler(messenger: messenger)
    }
}
