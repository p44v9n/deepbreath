//
//  ContentView.swift
//  SwiftUIMenuBar
//
//  Created by Aaron Wright on 12/18/19.
//  Copyright © 2019 Aaron Wright. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State var selectedTime = 0
    
    var body: some View {
        HStack {
            Picker("", selection: $selectedTime) {
                Text("5 breaths").tag(5)
                Text("10 breaths").tag(10)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
