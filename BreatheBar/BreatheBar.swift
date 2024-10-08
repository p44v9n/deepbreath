import KeyboardShortcuts
import SwiftUI

@main
struct DeepBreath2App: App {
  @StateObject private var popoverManager: PopoverManager
  @StateObject private var preferencesManager = PreferencesManager.shared
  @StateObject private var appState: AppState

  init() {
    let popoverManager = PopoverManager()
    _popoverManager = StateObject(wrappedValue: popoverManager)
    _appState = StateObject(wrappedValue: AppState(popoverManager: popoverManager))

  }

  var body: some Scene {

    Settings {
      EmptyView()
    }
  }

}

@MainActor
final class AppState: ObservableObject {
  private let popoverManager: PopoverManager
  @Published var showSplashScreen: Bool

  init(popoverManager: PopoverManager) {
    self.popoverManager = popoverManager
    self.showSplashScreen = !UserDefaults.standard.bool(forKey: "hasLaunchedBefore")

    KeyboardShortcuts.onKeyUp(for: .togglePopover) { [weak self] in
      self?.popoverManager.togglePopover(nil)
    }

    if showSplashScreen {
      UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
    }
  }
}
