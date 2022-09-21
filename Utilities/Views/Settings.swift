//
//  Settings.swift
//  Utilities
//
//  Created by SeanLi on 2022/9/23.
//

import SwiftUI

struct Setting: View {
    @AppStorage("clock") var clock: Double = 0.1
    @AppStorage("launch") var launchPath: String = "/bin/zsh"
    @State var clockCache = String(UserDefaults.standard.double(forKey: "clock"))
    var body: some View {
        TabView {
            VStack {
                Slider(value: $clock, in: 0...86400) {
                    Stepper("**Clock source** (shell feed update interval in seconds)", value: $clock,in: 0...86400, step: 0.01)
                    TextField("Clock Source", text: $clockCache)
                        .onSubmit {
                            if let co = Double(clockCache) {
                                if co <= Double(86400) {
                                    clock = co
                                } else {
                                    clockCache = String(clock)
                                }
                            } else {
                                clockCache = String(clock)
                            }
                        }
                        .textFieldStyle(.plain)
                        .frame(width: 100)
                }
                .onChange(of: clock) { _ in
                    clockCache = String(clock.formatted(.number.precision(.integerAndFractionLength(integer: 5, fraction: 3))))
                }
                .padding()
                HStack {
                    Text("**Launch Path** Default as zsh:")
                    Spacer()
                    TextField("Launch Path...", text: $launchPath)
                        .font(.system(size: 12, weight: .light, design: .monospaced))
                        .textFieldStyle(.plain)
                        .fixedSize()
                }
                .padding()
            }
            .tabItem {
                Label("Shell", systemImage: "terminal")
            }
        }
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        Setting()
    }
}
