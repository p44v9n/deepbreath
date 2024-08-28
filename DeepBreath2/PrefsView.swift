
import SwiftUI

struct PrefsView: View {
  @StateObject private var preferencesManager = PreferencesManager.shared
  @State private var selectedTab = 0

  var body: some View {
      VStack(spacing: 0) {
      CustomTabBar(selectedTab: $selectedTab)
        .padding(.top, 5)
      
      content
          Spacer()
    }
    .frame(width: 500, height: 300)

  }
  
  @ViewBuilder
  private var content: some View {
    switch selectedTab {
    case 0:
      GeneralView(preferencesManager: preferencesManager)
    case 1:
      DisplayView(preferencesManager: preferencesManager)
    case 2:
      Text("Reminders Settings")
    case 3:
      Text("About DeepBreath")
    default:
      EmptyView()
    }
  }
}


struct CustomTabBar: View {
  @Binding var selectedTab: Int

  var body: some View {
    HStack(spacing: 10) {
      TabBarButton(imageName: "tools", title: "General", isSelected: selectedTab == 0) {
        selectedTab = 0
      }
      TabBarButton(imageName: "display", title: "Display", isSelected: selectedTab == 1) {
        selectedTab = 1
      }
      TabBarButton(imageName: "clock", title: "Reminders", isSelected: selectedTab == 2) {
        selectedTab = 2
      }
      TabBarButton(imageName: "sun", title: "About", isSelected: selectedTab == 3) {
        selectedTab = 3
      }
    }
    .frame(width:.infinity, height: 60)

    .padding(20)
  }
}

struct TabBarButton: View {
  let imageName: String
  let title: String
  let isSelected: Bool
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      VStack {
        Image(imageName + (isSelected ? "-col" : "-grey")).resizable().frame(width: 40, height: 40)
        Text(title)
          .font(.caption)
      }
      .frame(width: 80)
      .padding(4)
    }

    .background(Color.clear)
  }
}

// Assuming these views are defined elsewhere in your project
struct GeneralView: View {
  @ObservedObject var preferencesManager: PreferencesManager

  var body: some View {
    Text("General Settings")
    // Add your General view content here
  }
}

struct DisplayView: View {
  @ObservedObject var preferencesManager: PreferencesManager

  var body: some View {
    Text("Display Settings")
    // Add your Display view content here
  }
}

#Preview {
    PrefsView()
}
