//
//  UtilitiesApp.swift
//  Utilities
//
//  Created by SeanLi on 2022/9/21.
//

import SwiftUI

@main
struct UtilitiesApp: App {
    @AppStorage("UtilList") var utilities: [Utility] = []
    var body: some Scene {
        WindowGroup {
            ContentView(utilities: $utilities)
        }
        .commands {
            UtilityCommands()
        }
        Settings {
            Setting()
        }
    }
}
