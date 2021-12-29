import SwiftUI

struct PopoverView: View {
    
    @State var count : Int
    @State var animationVisible = false
    
    var body: some View {
            
            if (!animationVisible) {
                HStack {
                    Picker("How many breaths:", selection: $count) {
                    Text("3 breaths").tag(3)
                    Text("5 breaths").tag(5)
                    //Text("10 breaths").tag(10)
                    //Text("15 breaths").tag(15)
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
                .clipped()
                .padding(10)
            }
            else {
                HStack {
                    
                    GifImage("black")
                    /*Text("Count: ")
                    Text(String(count))
                    */
                    // this timer stuff isn't working
                    let time = 15 * count
                    let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(time), repeats: false) { (timer) in
                        self.animationVisible = false
                    }
                    // after 15s x $count
                    // animationVisible = false
                }
              
                .frame(
                    minWidth: 250,
                    minHeight: 250
                    )
            }
        }
    }

/*
struct PopoverView_Preview: PreviewProvider {
    static var previews: some View {
        PopoverView()
    }
}
*/
