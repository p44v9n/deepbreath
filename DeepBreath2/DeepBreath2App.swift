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
        Settings {
            EmptyView()
        }
    }
}
