import Cocoa
import SwiftUI

class PreferencesWindowController: NSWindowController {

  convenience init() {
    let prefsView = PrefsView()
    let hostingController = NSHostingController(rootView: prefsView)

    let window = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: 300, height: 200),
      styleMask: [.titled, .closable, .miniaturizable],
      backing: .buffered,
      defer: false
    )
    window.contentViewController = hostingController
    window.title = "Preferences"

    // Center the window on the screen
    window.center()

    // Make the window a little bit higher than center
    if let screenHeight = NSScreen.main?.visibleFrame.height {
      window.setFrameOrigin(
        NSPoint(x: window.frame.origin.x, y: window.frame.origin.y + screenHeight * 0.1))
    }

    self.init(window: window)
    // Activate the app and bring the window to the front
    NSApp.activate(ignoringOtherApps: true)
    window.makeKeyAndOrderFront(self)

  }

  override func close() {
    super.close()
    // Ensure the window is deallocated when closed
    window?.contentViewController = nil
  }
}
