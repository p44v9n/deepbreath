import SwiftUI

struct MenuBarOptions: View {
    @State var count = 5
    
    var body: some View {
        HStack {
            Picker("", selection: $count) {
                Text("5 breaths").tag(5)
                Text("10 breaths").tag(10)
                Text("15 breaths").tag(15)
            }
                .frame(maxWidth: 120)
        
            Button("Start") {}
                .accentColor(.blue)
            
            Button("􀣌"){
                AppDelegate().openPrefs()
            }
                .accentColor(.white)
            

        }
        .clipped()
        .padding(10)
    }
}

struct MenuBarOptions_Previews: PreviewProvider {
    static var previews: some View {
        MenuBarOptions()
    }
}
