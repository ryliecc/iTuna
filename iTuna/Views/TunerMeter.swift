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

    var body: some View {
        let difference = detectedFrequency - targetFrequency
        let clamped = max(min(difference, 10), -10)  // max ±10 Hz

        return ZStack(alignment: .center) {
            // Hintergrund
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 20)
                .cornerRadius(10)

            // Marker
            Rectangle()
                .fill(clamped == 0 ? Color.green : Color.red)
                .frame(width: 10, height: 30)
                .offset(x: CGFloat(clamped) * 10)  // Skaliere für Sichtbarkeit
        }
        .padding()
    }
}

#Preview {
    TunerMeter(targetFrequency: 110.0, detectedFrequency: 108.5)
}
