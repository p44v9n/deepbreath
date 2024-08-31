import SwiftUI

struct ContentView: View {
  @ObservedObject private var preferencesManager = PreferencesManager.shared
  @State private var preferencesWindowController: PreferencesWindowController?
  @State private var durationInSeconds: Int
  @State private var animationVisible = false
  @Environment(\.presentationMode) var presentationMode  // Add this line
  @State private var showMenu = false
  @State private var timer: Timer?

  init() {
    _durationInSeconds = State(initialValue: PreferencesManager.shared.defaultDurationInSeconds)
    _animationVisible = State(initialValue: false)
  }

  var body: some View {

    if !animationVisible {
      VStack {
        HStack {
          Picker("How long:", selection: $durationInSeconds) {
            Text("20 seconds").tag(20)
            Text("1 minute").tag(60)
            Text("3 minutes").tag(180)
          }
          .frame(maxWidth: 120)
          .labelsHidden()

          Button("􀊄 Start") {
            animationVisible.toggle()
            if animationVisible {
              startTimer()
            } else {
              timer?.invalidate()
            }
          }
          .accentColor(.blue)
          Button("􀍠") {
            showMenu.toggle()
          }
          .accentColor(.white)
        }
        .clipped()

        if showMenu {
          HStack {
            Button("􀣌 Preferences") {
              showPreferences()
            }
            Button("􀁡 Quit") {
              NSApplication.shared.terminate(nil)
            }
          }
        }
      }.padding(10)
    } else {
      ZStack(alignment: .topLeading) {
        VStack {
          AnimationView(
            count: $durationInSeconds, isAnimating: $animationVisible, onComplete: closePopover)

          // rough estimate of remaining breaths
          if PreferencesManager.shared.showBreathCount {
            Text("Remaining breaths: \(Int(ceil(Double(durationInSeconds) / 6.0)))")
          }
        }

        // Close button
        Button {
          closePopover()
        } label: {
          Image(systemName: "xmark.circle.fill")
            .foregroundColor(Color(.lightGray))
        }
        .buttonStyle(PlainButtonStyle())
        .padding(10)
      }
      .frame(
        width: sizeForPopover().width,
        height: sizeForPopover().height
      )
      .padding(10)
    }
  }

  private func showPreferences() {
    if preferencesWindowController == nil {
      preferencesWindowController = PreferencesWindowController()
    }
    preferencesWindowController?.showWindow(nil)
  }

  private func closePopover() {
    animationVisible = false  // This will trigger the animation to stop
    durationInSeconds = PreferencesManager.shared.defaultDurationInSeconds  // Reset count to default
    self.presentationMode.wrappedValue.dismiss()
    timer?.invalidate()  // Invalidate the timer when closing manually
  }

  private func startTimer() {
    timer?.invalidate()  // Invalidate any existing timer
    timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(durationInSeconds), repeats: false)
    { _ in
      closePopover()
    }
  }

  private func sizeForPopover() -> (width: CGFloat, height: CGFloat) {
    switch preferencesManager.popoverSize {
    case "sm":
      return (width: 250, height: 250)
    case "md":
      return (width: 300, height: 300)
    case "lg":
      return (width: 350, height: 350)
    default:
      return (width: 250, height: 250)
    }
  }
}

#Preview {
  ContentView()
}
