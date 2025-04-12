//
//  Shakey_WakeyApp.swift
//  Shakey Wakey
//
//  Created by Johan Karlsson on 2025-04-12.
//

import SwiftUI

@main
struct Shakey_WakeyApp: App {
    init() {
        NotificationManager.shared.requestAuthorization()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
