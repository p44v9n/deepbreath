//
//  PrefsView.swift
//  DeepBreath
//
//  Created by Paavan Buddhdev on 22/12/2021.
//  Copyright © 2021 Paavan Buddhdev. All rights reserved.
//

import SwiftUI

struct PrefsView: View {
    @Binding var count: Int
    
    @State var launchOnLogin = false
    @State var checkForUpdates = false

    var body: some View {
        
        VStack(alignment: .leading) {

            Toggle("Launch on login", isOn: $launchOnLogin)
                .disabled(true)
            Toggle("Automatically check for updates", isOn: $checkForUpdates)
                .disabled(true)
            
            //Divider().padding(.vertical, 8)
            
            HStack{
                Picker("Default amount:", selection: $count) {
                    Text("5 breaths").tag(5)
                    Text("10 breaths").tag(10)
                    Text("15 breaths").tag(15)
                }
            }
            
            Divider().padding(.vertical, 8)
            
            Text("Contribute at:")
            Link("https://github.com/p44v9n/deepbreath", destination: URL(string: "https://github.com/p44v9n/deepbreath")!)
        }
        .padding(40)
        .frame(maxWidth: 400)
    }
    
}

/*
struct PrefsView_Previews: PreviewProvider {
    @Binding var defaultCount: Int
    static var previews: some View {
        PrefsView(defaultCount: $defaultCount)
    }
}
*/
