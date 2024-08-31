import Foundation
import RiveRuntime
import SwiftUI

struct AnimationView: View {
  @Binding var count: Int
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

    .onChange(of: prefsManager.animationStyle) { oldValue, newValue in
      loadAnimation()
    }
  }

  private func loadAnimation() {
    let fileName: String
    switch prefsManager.animationStyle {
    case 1:
      fileName = "breathing1"
    case 2:
      fileName = "breathing2"
    case 3:
      fileName = "breathing3"
    default:
      fileName = "breathing1"
    }
    self.rive = RiveViewModel(fileName: fileName, stateMachineName: "State Machine 1")

  }

}

