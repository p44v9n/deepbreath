//
//  Animation.swift
//  DeepBreath2
//
//  Created by Paavan Buddhdev on 27/08/2024.
//

import Foundation
import RiveRuntime
import SwiftUI

struct AnimationView: View {
  @Binding var count: Int
  @Binding var isAnimating: Bool  // Add this line
  var onComplete: () -> Void
  @State private var riveViewModel: RiveViewModel?
  @State private var animationWorkItem: DispatchWorkItem?

  // Adjust this value to match your animation's duration
  private let animationDuration: Double = 6.5  // in seconds

  var body: some View {
    VStack {
      if let riveViewModel = riveViewModel {
        riveViewModel.view()
          .onAppear {
            startAnimation()
          }
      } else {
        Text("Loading animation...")
          .onAppear {
            self.riveViewModel = RiveViewModel(fileName: "breathing1")
          }
      }
      Text("Remaining breaths: \(count)")
    }
    .onChange(of: isAnimating) { newValue in
      if !newValue {
        stopAnimation()
      }
    }
  }

  private func startAnimation() {
    guard count > 0, let riveViewModel = riveViewModel, isAnimating else {
      onComplete()
      return
    }

    // Cancel any existing animation work item
    animationWorkItem?.cancel()

    // Play the animation
    riveViewModel.reset()
    riveViewModel.play(animationName: "Timeline 1")  // Adjust this if your animation has a different name

    // Create a new work item
    let workItem = DispatchWorkItem {
      count -= 1
      startAnimation()
    }

    // Store the work item
    animationWorkItem = workItem

    // Schedule the work item
    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration, execute: workItem)
  }

  private func stopAnimation() {
    animationWorkItem?.cancel()
    animationWorkItem = nil
    riveViewModel?.reset()
  }
}
