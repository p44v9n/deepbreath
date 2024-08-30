import SwiftUI

@main
struct DeepBreath2App: App {
  @StateObject private var popoverManager: PopoverManager
  @StateObject private var preferencesManager = PreferencesManager.shared

  init() {
    let popoverManager = PopoverManager()
    _popoverManager = StateObject(wrappedValue: popoverManager)
  }

  var body: some Scene {
    MenuBarExtra {
      ContentView()
    } label: {
        Text("Deep Breath")
    }
    .menuBarExtraStyle(.window)
    .commands {
      CommandGroup(replacing: .appInfo) {
        Button("About Deep Breath") {
          NSApplication.shared.orderFrontStandardAboutPanel(
            options: [
              NSApplication.AboutPanelOptionKey.credits: NSAttributedString(
                string: "Deep Breath is a simple app to help you take a moment to breathe.",
                attributes: [
                  NSAttributedString.Key.font: NSFont.systemFont(ofSize: NSFont.smallSystemFontSize)
                ]
              ),
              NSApplication.AboutPanelOptionKey.applicationVersion:
                "Version \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "")",
            ]
          )
        }
      }
    }
  }
}
