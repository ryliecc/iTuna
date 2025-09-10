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
    var inputNode: AVAudioInputNode
    private var bus: AVAudioNodeBus = 0

    @Published var currentAmplitude: Float = 0.0
    @Published var currentBuffer: [Float] = []

    init() {
        engine = AVAudioEngine()
        inputNode = engine.inputNode
    }

    func ensureMicrophoneAccess(completion: @escaping (Bool) -> Void) {
        let discoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.microphone],
            mediaType: .audio,
            position: .unspecified
        )

        let devices = discoverySession.devices
        guard !devices.isEmpty else {
            print("⚠️ Kein Mikrofon verfügbar")
            completion(false)
            return
        }

        AVCaptureDevice.requestAccess(for: .audio) { granted in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }

    func start() {
        ensureMicrophoneAccess { granted in
            guard granted else {
                print("⚠️ Kein Mikrofonzugriff")
                return
            }

            let format = self.inputNode.inputFormat(forBus: self.bus)
            self.inputNode.removeTap(onBus: self.bus)

            self.inputNode.installTap(
                onBus: self.bus,
                bufferSize: 1024,
                format: format
            ) { buffer, _ in
                guard let channelData = buffer.floatChannelData?[0] else {
                    return
                }
                let array = Array(
                    UnsafeBufferPointer(
                        start: channelData,
                        count: Int(buffer.frameLength)
                    )
                )
                DispatchQueue.main.async {
                    self.currentBuffer = array
                    self.currentAmplitude = array.map { abs($0) }.max() ?? 0.0
                    print("🎙️ Buffer received: \(array.count) samples")
                }
            }

            do {
                try self.engine.start()
                print("✅ AudioEngine gestartet")
            } catch {
                print(
                    "⚠️ AudioEngine konnte nicht gestartet werden: \(error.localizedDescription)"
                )
            }
        }
    }

    func stop() {
        inputNode.removeTap(onBus: bus)
        engine.stop()
    }

    func detectPitch(from buffer: [Float], sampleRate: Float) -> Float? {
        guard !buffer.isEmpty else { return nil }

        var maxCorrelation: Float = 0
        var bestLag: Int = 0
        let bufferCount = buffer.count

        // Autocorrelation
        for lag in 20..<bufferCount / 2 {
            var correlation: Float = 0
            for i in 0..<(bufferCount - lag) {
                correlation += buffer[i] * buffer[i + lag]
            }

            if correlation > maxCorrelation {
                maxCorrelation = correlation
                bestLag = lag
            }
        }

        guard bestLag != 0 else { return nil }

        let frequency = sampleRate / Float(bestLag)
        return frequency
    }
}
