//
//  GuitarString.swift
//  iTuna
//
//  Created by Rylie Castell on 10.09.25.
//

import Foundation

struct GuitarString {
    let name: String
    let frequency: Float

    static let standardTuning: [GuitarString] = [
        GuitarString(name: "E2", frequency: 82.41),
        GuitarString(name: "A2", frequency: 110.00),
        GuitarString(name: "D3", frequency: 146.83),
        GuitarString(name: "G3", frequency: 196.00),
        GuitarString(name: "B3", frequency: 246.94),
        GuitarString(name: "E4", frequency: 329.63),
    ]

    static func nearestString(for frequency: Float) -> GuitarString? {
        standardTuning.min(by: {
            abs($0.frequency - frequency) < abs($1.frequency - frequency)
        })
    }

}
