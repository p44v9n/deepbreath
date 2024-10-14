import Foundation
import RiveRuntime
import SwiftUI

struct AnimationView: View {
  @Binding var count: Int
  @Binding var duration: (name: String, value: Int)
  @Binding var isAnimating: Bool
  var onComplete: () -> Void
  @State private var rive: RiveViewModel?
  @ObservedObject private var prefsManager = PreferencesManager.shared

  var body: some View {
    VStack {
      if let rive = rive {
        rive.view()
      } else {
        Text("Loading animation...")
          .onAppear {
            loadAnimation()
          }
      }
    }

    .onChange(of: prefsManager.animationStyle) { newValue in
      loadAnimation()
    }
  }

  private func loadAnimation() {
    let fileName: String
    switch prefsManager.animationStyle {
    case 1:
      fileName = "breathing_orb"
    case 2:
      fileName = "breathing_text"
    default:
      fileName = "breathing_orb"
    }
    self.rive = RiveViewModel(fileName: fileName, stateMachineName: duration.name)

  }

}
