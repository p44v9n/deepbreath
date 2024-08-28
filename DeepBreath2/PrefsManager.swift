import SwiftUI

class PreferencesManager: ObservableObject {
    @AppStorage("defaultCount") var defaultCount: Int = 3
    @AppStorage("checkForUpdates") var checkForUpdates: Bool = false
    
    @AppStorage("menuBarIcon") var menuBarIcon: String = "Monochrome"
    @AppStorage("showBreathCount") var showBreathCount: Bool = true
    @AppStorage("animationStyle") var animationStyle: String = "Circles"
    
    static let shared = PreferencesManager()
    
    private init() {}
}
