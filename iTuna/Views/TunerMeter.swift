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
    @State private var displayedOffset: CGFloat = 0

    var body: some View {
        let difference = detectedFrequency - targetFrequency
        let clamped = max(min(difference, 10), -10)
        let targetOffset = CGFloat(clamped) * 10

        return ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2))
                .frame(height: 20)

            Rectangle()
                .fill(Color.red)
                .frame(width: 4, height: 30)
                .offset(x: displayedOffset)
                .animation(.easeOut(duration: 0.1), value: displayedOffset)
        }
        .padding()
        .onChange(of: detectedFrequency) { _ in
            displayedOffset = targetOffset
        }
    }
}

#Preview {
    TunerMeter(targetFrequency: 110.0, detectedFrequency: 108.5)
}
