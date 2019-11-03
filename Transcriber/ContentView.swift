//
//  ContentView.swift
//  Transcriber
//
//  Created by Jonathon Frisby on 11/3/19.
//  Copyright © 2019 Mat Ellis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var transcriptionHandler: () -> Void
    var body: some View {
        Button(action: transcriptionHandler) {
            Text("Click me!")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(transcriptionHandler: {})
    }
}
