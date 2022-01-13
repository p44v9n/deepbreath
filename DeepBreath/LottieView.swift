// from https://stackoverflow.com/questions/68278543/making-lottie-work-with-macos-and-appkit-without-uikit

import SwiftUI
import Lottie

struct LottieView: NSViewRepresentable {

//To allow the JSON file to be read and to display the animaton
//Allows link to SwiftUI from NSView()
let animationView = AnimationView()
var filename : String //The name of the file to be loaded
var speed: Double //The speed at which the animation should be played
var loop: LottieLoopMode //Whever the animation should loop
var heightView: Double
var widthView: Double

func makeNSView(context: NSViewRepresentableContext<LottieView>) -> NSView {
    let view = NSView()
    let animation = Animation.named(filename) //Loads the animation
    animationView.animation = animation //Sets the animation
    animationView.animationSpeed = CGFloat(speed) //Speed
    animationView.contentMode = .scaleAspectFit //Aspect Ratio
    animationView.loopMode = loop // Whether to loop
    animationView.play() //Plays the animation
    
    animationView
        .translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(animationView)
    view.setFrameSize(CGSize(width: 100, height: 100))
    
    NSLayoutConstraint.activate([
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        animationView.heightAnchor.constraint(equalToConstant: CGFloat(heightView)),
        animationView.widthAnchor.constraint(equalToConstant: CGFloat(widthView))

    ])
    
    return view //Necessary in order to conform to UIVieewRepresentable

}

func updateNSView(_ uiView: NSView, context: NSViewRepresentableContext<LottieView> ) {
    
 }
}
