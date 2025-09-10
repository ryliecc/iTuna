//
//  AudioManager.swift
//  iTuna
//
//  Created by Rylie Castell on 10.09.25.
//

import AVFoundation
import Combine
import Foundation

class AudioManager: ObservableObject {
    private var engine: AVAudioEngine
    private var inputNode: AVAudioInputNode
    private var bus: AVAudioNodeBus = 0

    @Published var currentAmplitude: Float = 0.0
    @Published var currentBuffer: [Float] = []

    init() {
        engine = AVAudioEngine()
        inputNode = engine.inputNode
    }

    func start() {
        let format = inputNode.outputFormat(forBus: bus)

        inputNode.installTap(onBus: bus, bufferSize: 1024, format: format) {
            buffer,
            _ in
            guard let channelData = buffer.floatChannelData?[0] else { return }
            let channelDataArray = Array(
                UnsafeBufferPointer(
                    start: channelData,
                    count: Int(buffer.frameLength)
                )
            )

            DispatchQueue.main.async {
                self.currentBuffer = channelDataArray
                self.currentAmplitude =
                    channelDataArray.map { abs($0) }.max() ?? 0.0
            }
        }

        do {
            try engine.start()
        } catch {
            print(
                "⚠️ AudioEngine konnte nicht gestartet werden: \(error.localizedDescription)"
            )
        }
    }

    func stop() {
        inputNode.removeTap(onBus: bus)
        engine.stop()
    }
}
