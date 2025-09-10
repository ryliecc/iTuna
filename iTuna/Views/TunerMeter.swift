//
//  TunerMeter.swift
//  iTuna
//
//  Created by Rylie Castell on 10.09.25.
//

import SwiftUI

struct TunerMeter: View {
    let targetFrequency: Float
    let detectedFrequency: Float
    @State private var displayedAngle: Double = 0

    var body: some View {
        let difference = detectedFrequency - targetFrequency
        let clamped = max(min(difference, 10), -10)
        let targetAngle = Double(clamped) * 9

        return ZStack {
            Circle()
                .trim(from: 0, to: 0.5)
                .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                .rotationEffect(.degrees(180))

            Circle()
                .trim(from: 0.25 - 0.02, to: 0.25 + 0.02)
                .stroke(Color.green, lineWidth: 20)
                .rotationEffect(.degrees(180))

            Rectangle()
                .fill(Color.red)
                .frame(width: 4, height: 70)
                .offset(y: -35)
                .rotationEffect(.degrees(displayedAngle))
        }
        .frame(width: 200, height: 100)
        .padding()
        .onChange(of: detectedFrequency) {
            withAnimation(.easeOut(duration: 0.1)) {
                displayedAngle = targetAngle
            }
        }
    }
}

#Preview {
    TunerMeter(targetFrequency: 110.0, detectedFrequency: 108.5)
}
