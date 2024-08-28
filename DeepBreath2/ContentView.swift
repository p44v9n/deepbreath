import SwiftUI

struct ContentView: View {
  @ObservedObject private var preferencesManager = PreferencesManager.shared
  @State private var breathCount: Int
  @State private var preferencesWindowController: PreferencesWindowController?
  @State private var count: Int
  @State private var animationVisible = false
  @Environment(\.presentationMode) var presentationMode  // Add this line
  @State private var showMenu = false

  init() {
    _breathCount = State(initialValue: PreferencesManager.shared.defaultCount)
    _count = State(initialValue: PreferencesManager.shared.defaultCount)
  }

  var body: some View {

    if !animationVisible {
      VStack {
        HStack {
          Picker("How many breaths:", selection: $count) {
            //                    Text("1 breath").tag(1) // for debugging — comment out
            Text("3 breaths").tag(3)
            Text("5 breaths").tag(5)
            Text("10 breaths").tag(10)
            Text("15 breaths").tag(15)
          }
          .frame(maxWidth: 120)
          .labelsHidden()

          Button("􀊄 Start") {
            animationVisible.toggle()
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
        AnimationView(count: $count, isAnimating: $animationVisible, onComplete: closePopover)

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
        minWidth: 250,
        minHeight: 250
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
    count = PreferencesManager.shared.defaultCount  // Reset count to default
    self.presentationMode.wrappedValue.dismiss()
  }
}

#Preview {
    ContentView()
}
