import SwiftUI

struct PopoverView: View {
    
    @State var count : Int
    @State var animationVisible = false
    
    var body: some View {
            
            if (!animationVisible) {
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
                
                ZStack(alignment: .topLeading) {
                    
                    // Animation
                    LottieView(filename: "grey", speed: 1.0, loop: .repeat(Float(count)), heightView: 250, widthView: 250).frame(width: 250, height: 250, alignment: .center)
                    
                    // Close animation after its done
                    // There should be a better way of doing this using the LottieView completed instead of creating a timer
                    let time = 10 * Double(count)
                    let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(time), repeats: false) { (timer) in
                        self.animationVisible = false
                    }
                    
                    // Close button
                    Button{
                        print("press")
                        animationVisible = false
                        
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(.lightGray))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(10)
                    
/*                  //Gif implementation
                    GifImage("grey")
                    let countAsDouble = Double(count)
                    let time = 10.2 * countAsDouble
                    let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(time), repeats: false) { (timer) in
                        self.animationVisible = false
                    }
 */
                 
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
 
 var previewCount = 5
 struct PopoverView_Preview: PreviewProvider {
    
    static var previews: some View {
        PopoverView(count: previewCount)
    }
}

 */
