import SwiftUI


class PreferencesManager: ObservableObject {
    @AppStorage("defaultCount") var defaultCount: Int = 3
    @AppStorage("checkForUpdates") var checkForUpdates: Bool = false
    @AppStorage("popoverSize") var popoverSize: String = "sm"
    @AppStorage("menuBarIcon") var menuBarIcon: String = "Monochrome"
    @AppStorage("showBreathCount") var showBreathCount: Bool = true
    @AppStorage("animationStyle") var animationStyle: Int = 1
    
    @AppStorage("timeBreatheIn") var timeBreatheIn: Int = 5
    @AppStorage("timeBreatheHold") var timeBreatheHold: Int = 5
    @AppStorage("timeBreatheOut") var timeBreatheOut: Int = 5

    static let shared = PreferencesManager()
    
    private init() {}
}
