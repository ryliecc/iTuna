//
//  ContentView.swift
//  iTuna
//
//  Created by Rylie Castell on 10.09.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var audioManager = AudioManager()

    var body: some View {
        VStack {
            Text("🎸 Guitar Tuner")
                .font(.headline)

            Text(
                "Amplitude: \(audioManager.currentAmplitude, specifier: "%.4f")"
            )
            .padding()

            Button("Start Listening") {
                audioManager.start()
            }
            Button("Stop Listening") {
                audioManager.stop()
            }
        }
        .padding()
        .frame(width: 200, height: 150)
    }
}

#Preview {
    ContentView()
}
