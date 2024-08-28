
import SwiftUI
import RiveRuntime

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
        .frame(width: 500)
        
    }
    
    @ViewBuilder
    private var content: some View {
        switch selectedTab {
        case 0:
            GeneralPrefsView(preferencesManager: preferencesManager)
        case 1:
            DisplayPrefsView(preferencesManager: preferencesManager)
        case 2:
            Text("Reminders Settings")
        case 3:
            AboutPrefsView(preferencesManager: preferencesManager)
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
        .frame(width:500, height: 60)
        
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

struct GeneralPrefsView: View {
    @ObservedObject var preferencesManager: PreferencesManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            
            
            Toggle(isOn: .constant(false), label: {
                Text("Open DeepBreath at Login")
            }).disabled(true)
            HStack(alignment: .firstTextBaseline, spacing: 10, content: {
                Toggle(isOn: .constant(false), label: {
                    Text("Check automatically for updates")
                }).disabled(true)
                Button("Check now..."){}.disabled(true)
            }
            )
            Divider().frame(width: 440)
            Picker("Default amount:", selection: $preferencesManager.defaultCount){
                Text("3 breaths").tag(3)
                Text("5 breaths").tag(5)
                Text("10 breaths").tag(10)
                Text("15 breaths").tag(15)
            }.frame(width: 200)
            
            VStack(alignment: .leading, spacing: 5, content: {
                Toggle(isOn: .constant(false), label: {
                    Text("Start On Press")
                }).disabled(true)
                Text("Start the animation straight away when clicking on the menu bar icon, instead of opening a menu").font(.system(size: 11)).foregroundStyle(Color.gray).fixedSize(horizontal: false, vertical: true).frame(width:420)
            })
            VStack(alignment: .leading, spacing: 5, content: {
                Toggle(isOn: .constant(false), label: {
                    Text("Use audio cues")
                }).disabled(true)
                Text("Shut your eyes and take a break from the screen. Audio cues let you know when to breathe in and breathe out.").font(.system(size: 11)).foregroundStyle(Color.gray).fixedSize(horizontal: false, vertical: true).frame(width:440)
            })
            
        })
    }
}

struct DisplayPrefsView: View {
    @ObservedObject var preferencesManager: PreferencesManager
    
    var body: some View {
        Text("Display Settings")
        // Add your Display view content here
    }
}

struct AboutPrefsView: View {
    @ObservedObject var preferencesManager: PreferencesManager
    @State private var riveViewModel: RiveViewModel?
    
    var body: some View {
        VStack {
            if let riveViewModel = riveViewModel {
                riveViewModel.view()
                    .frame(width: 100, height: 100)
            } else {
                Text("Loading animation...")
                    .onAppear {
                        self.riveViewModel = RiveViewModel(fileName: "breathing1")
                        self.riveViewModel?.play(animationName: "Timeline 1")
                    }
            }
            VStack(spacing: 10, content: {
                Text("**Deep Breath**").font(.system(size:17))
                Text("􀪥 Contribute on [GitHub](https://github.com/p44v9n/deepbreath).")
                Text("􁞵 Donate with [Ko-fi](https://ko-fi.com/p44v9n/).")
                Text("􀟱 Made by [Paavan](https://paavandesign.com)")
            })
        }
    }
}

#Preview {
    PrefsView()
}

