import KeyboardShortcuts
import SwiftUI

@main
struct BreatheBar: App {
  @StateObject private var popoverManager: PopoverManager
  @StateObject private var preferencesManager = PreferencesManager.shared
  @StateObject private var appState: AppState
  @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

  init() {
    let popoverManager = PopoverManager()
    _popoverManager = StateObject(wrappedValue: popoverManager)
    _appState = StateObject(wrappedValue: AppState(popoverManager: popoverManager))

  }

  var body: some Scene {
    WindowGroup {
      if !hasCompletedOnboarding {
        WelcomeView()
      } else {
        EmptyView()
      }
    }

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
  }
}
