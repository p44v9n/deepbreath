//
//  PrefsView.swift
//  DeepBreath
//
//  Created by Paavan Buddhdev on 22/12/2021.
//  Copyright © 2021 Paavan Buddhdev. All rights reserved.
//

import SwiftUI

struct PrefsView: View {
    
    @State private var launchOnLogin = true
    @State private var checkForUpdates = true
    @State private var defaultCount = 5

    var body: some View {
        VStack(alignment: .leading) {

            Toggle("Launch on login", isOn: $launchOnLogin)
            Toggle("Automatically check for updates", isOn: $checkForUpdates)
            
            Divider()
                .padding(.vertical, 8)
            HStack{
                Text("Default amount:")
                Spacer()
                Picker("", selection: $defaultCount) {
                    Text("5 breaths").tag(5)
                    Text("10 breaths").tag(10)
                }
            }
        }
        .padding(40)
        .frame(maxWidth: 400)
    }
    
}

struct PrefsView_Previews: PreviewProvider {
    static var previews: some View {
        PrefsView()
    }
}
