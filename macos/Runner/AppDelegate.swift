import Cocoa
import FlutterMacOS

@available(macOS 12.0, *)
@main
class AppDelegate: FlutterAppDelegate {
    private var platformChannelRegistrar: PlatformChannelRegistrar?

    override func applicationDidFinishLaunching(_ notification: Notification) {
        // Ensure the Flutter view controller is available
        guard let flutterViewController = mainFlutterWindow?.contentViewController as? FlutterViewController else {
            fatalError("Unable to retrieve Flutter view controller.")
        }

        // Initialize the PlatformChannelRegistrar to register all platform-specific Method Channels
        platformChannelRegistrar = PlatformChannelRegistrar(messenger: flutterViewController.engine.binaryMessenger)
        platformChannelRegistrar?.registerHandlers()
        
        super.applicationDidFinishLaunching(notification)
    }

    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
