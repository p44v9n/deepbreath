import SwiftUI

struct PopoverView: View {
    @State var count = 5
    @Binding var defaultCountImport: Int
    
    @State var animationVisible = false
    
    var body: some View {
        HStack {
            if (!animationVisible) {
                Picker("", selection: $defaultCountImport) {
                    Text("5 breaths").tag(5)
                    Text("10 breaths").tag(10)
                    Text("15 breaths").tag(15)
                }
                    .frame(maxWidth: 120)
            
                Button("Start") {
                    animationVisible.toggle()
                }
                    .accentColor(.blue)
                
                Button("􀣌"){
                    AppDelegate().openPrefs()
                }
                    .accentColor(.white)
            }
            else {
                GifImage("black")
            }
        }
        .clipped()
        .padding(10)
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
        }
    }
    




/*
struct PopoverView_Preview: PreviewProvider {
    static var previews: some View {
        PopoverView()
    }
}
*/
