//
//  ContentView.swift
//  iTuna
//
//  Created by Rylie Castell on 10.09.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var audioManager = AudioManager()
    @State private var detectedFrequency: Float?
    @State private var nearestNote: String = "-"

    var body: some View {
        VStack {
            Text("🎸 Guitar Tuner")
                .font(.headline)

            Text(
                "Amplitude: \(audioManager.currentAmplitude, specifier: "%.4f")"
            )
            .padding()

            if let freq = detectedFrequency,
                let target = GuitarString.nearestString(for: freq)
            {
                Text("Frequency: \(freq, specifier: "%.1f") Hz")
                Text("Nearest Note: \(target.name)")
                TunerMeter(
                    targetFrequency: target.frequency,
                    detectedFrequency: freq
                )
            } else {
                Text("Frequency: -")
                Text("Nearest Note: -")
            }

            HStack(spacing: 10) {
                Button("Start Listening") {
                    audioManager.start()
                    startPitchUpdates()
                }
                Button("Stop Listening") {
                    audioManager.stop()
                }
            }
        }
        .padding()
        .frame(width: 300)
    }

    private func startPitchUpdates() {
        let format = audioManager.inputNode.inputFormat(forBus: 0)
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            let buffer = audioManager.currentBuffer
            let sampleRate = Float(format.sampleRate)

            if let freq = audioManager.detectPitch(
                from: buffer,
                sampleRate: sampleRate
            ) {
                detectedFrequency = freq
                nearestNote = GuitarString.nearestString(for: freq)?.name ?? "-"
            }
        }
    }
}

#Preview {
    ContentView()
}
