//
//  iTunaApp.swift
//  iTuna
//
//  Created by Rylie Castell on 10.09.25.
//

import SwiftUI

@main
struct iTunaApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
