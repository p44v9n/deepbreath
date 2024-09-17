import SwiftUI

class PreferencesManager: ObservableObject {
  @AppStorage("defaultDurationName") var defaultDurationName: String = "Short"
  @AppStorage("defaultDurationValue") var defaultDurationValue: Int = 20

  var defaultDuration: (name: String, value: Int) {
    get { (defaultDurationName, defaultDurationValue) }
    set {
      defaultDurationName = newValue.name
      defaultDurationValue = newValue.value
      objectWillChange.send()
    }
  }

  @AppStorage("checkForUpdates") var checkForUpdates: Bool = false
  @AppStorage("popoverSize") var popoverSize: String = "sm"
  @AppStorage("menuBarIcon") var menuBarIcon: String = "Monochrome"
  @AppStorage("showBreathCount") var showBreathCount: Bool = false
  @AppStorage("animationStyle") var animationStyle: Int = 1

  @AppStorage("timeBreatheIn") var timeBreatheIn: Int = 5
  @AppStorage("timeBreatheHold") var timeBreatheHold: Int = 5
  @AppStorage("timeBreatheOut") var timeBreatheOut: Int = 5

  static let shared = PreferencesManager()

  private init() {}
}
