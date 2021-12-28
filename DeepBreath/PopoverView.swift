import SwiftUI

struct PopoverView: View {
    @Binding var count : Int
    //@Binding var defaultCountImport: Int
    @State var animationVisible = false
    
    var body: some View {
        HStack {
            if (!animationVisible) {
                Picker("How many breaths:", selection: $count) {
                    Text("3 breaths").tag(3)
                    Text("5 breaths").tag(5)
                    Text("10 breaths").tag(10)
                    Text("15 breaths").tag(15)
                }
                    .frame(maxWidth: 120)
                    .labelsHidden()
            
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
                let time = 15 * count;
                let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(time), repeats: false) { (timer) in
                    animationVisible = false
                }
                // after 15s x $count
                // animationVisible = false
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
