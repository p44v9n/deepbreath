import LaunchAtLogin
import RiveRuntime
import SwiftUI

struct WelcomeView: View {
  @State private var currentStep = 0
  @State private var riveText = RiveViewModel(fileName: "breathing_text")
  @State private var riveOrb = RiveViewModel(fileName: "breathing_orb")
  @StateObject private var preferencesManager = PreferencesManager.shared
  @State private var rotation: Double = 0
  @State private var launchAtLogin = false
  @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

  var body: some View {
    Group {
      if !hasCompletedOnboarding {
        VStack {
          switch currentStep {
          case 0:
            firstStep
          case 1:
            secondStep
          case 2:
            thirdStep
          default:
            EmptyView()
          }
        }
        .frame(width: 400, height: 300)
        .background(Color.white)
      } else {
        EmptyView()
      }
    }
    .frame(width: 400, height: 300)
    .fixedSize()
    .background(
      WindowAccessor { window in
        window.styleMask.remove(.resizable)
        window.setContentSize(NSSize(width: 400, height: 300))
      })

  }

  var firstStep: some View {
    VStack {
      if let appIcon = NSImage(named: NSImage.applicationIconName) {
        Image(nsImage: appIcon)
          .resizable()
          .scaledToFill()
          .frame(width: 100, height: 100)

          .rotationEffect(.degrees(rotation))
          .onAppear {
            withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
              rotation = 360
            }
          }
      }
      Text("Welcome to BreatheBar")
        .font(.title)
        .padding()

      Button("Continue") {
        currentStep += 1
      }
    }
    .frame(width: 400)
  }

  var secondStep: some View {
    VStack(spacing: 0) {
      VStack {
        Text("To start using BreatheBar,\nclick on this icon in your menu bar.")
          .multilineTextAlignment(.center)
          .padding(.top, 40)
        Spacer()
      }
      .frame(width: 400, height: 250.0)
      .background(
        Image("Welcome")
          .resizable()
          .scaledToFill()
      )

      Divider()

      HStack {
        Spacer()
        Button("Continue") {
          currentStep += 1
        }
        .padding()
      }
      .background(Color.white)
    }
    .frame(width: 400)
  }
  var thirdStep: some View {
    VStack(spacing: 0) {
      VStack {

        Text("Choose Your Look")
          .font(.title3)
          .multilineTextAlignment(.center)
          .padding(.top, 40)
        HStack(spacing: 20) {
          VStack {
            riveOrb.view()
              .frame(width: 100, height: 100)
              .background(Color.gray.opacity(0.2))
              .cornerRadius(10)
              .overlay(
                RoundedRectangle(cornerRadius: 10)
                  .stroke(
                    preferencesManager.animationStyle == 2 ? Color.blue : Color.clear, lineWidth: 3)
              )
          }
          .onTapGesture {
            preferencesManager.animationStyle = 2
          }
          VStack {
            riveText.view()
              .frame(width: 100, height: 100)
              .background(Color.gray.opacity(0.2))
              .cornerRadius(10)
              .overlay(
                RoundedRectangle(cornerRadius: 10)
                  .stroke(
                    preferencesManager.animationStyle == 1 ? Color.blue : Color.clear, lineWidth: 3)
              )
          }
          .onTapGesture {
            preferencesManager.animationStyle = 1
          }
        }
        .padding()
      }
      Spacer()
      Divider()
      Spacer()

      HStack {
        LaunchAtLogin.Toggle()
          .padding()
        Spacer()
        Button("Start") {
          NSApplication.shared.keyWindow?.close()
          hasCompletedOnboarding = true
        }
        .padding()
      }
      .background(Color.white)
    }
    .frame(width: 400)
  }

}

#Preview {
  WelcomeView()
}
