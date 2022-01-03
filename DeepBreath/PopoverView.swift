import SwiftUI

struct PopoverView: View {
    
    @State var count : Int
    @State var animationVisible = false
    
    var body: some View {
            
            if (!animationVisible) {
                HStack {
                    Picker("How many breaths:", selection: $count) {
                    Text("1 breath").tag(1) // for debugging — comment out
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
                .clipped()
                .padding(10)
            }
            else {
                ZStack(alignment: .top){
                    // Animation
                    GifImage("grey")
                    let countAsDouble = Double(count)
                    let time = 10.2 * countAsDouble
                    let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(time), repeats: false) { (timer) in
                        self.animationVisible = false
                    }
                    
                    // Close button
                    Button{
                        print("press")
                        animationVisible = false
                        
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                 
                }
              
                .frame(
                    minWidth: 250,
                    minHeight: 250
                )
                .padding(10)
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
