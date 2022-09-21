//
//  UtilityRunner.swift
//  Utilities
//
//  Created by SeanLi on 2022/9/21.
//

import SwiftUI

struct UtilityRunner: View {
    @Binding var father: [Utility]
    @State var logFile: String = ""
    @State var run: Bool = false
    var utility: Utility
    var timer = Timer.publish(every: UserDefaults.standard.double(forKey: "clock"), on: .main, in: .common).autoconnect()
    var body: some View {
        VStack {
            HStack {
                Text(utility.name)
                    .font(
                        .system(
                            size: 25,
                            weight: .semibold,
                            design: .rounded
                        )
                    )
                SheetButton(padding: 10, showDismissButton: false) {
                    EditView(father: $father, original: utility)
                } label: {
                    Label("Edit", systemImage: "pencil")
                        .foregroundColor(.accentColor)
                }
                Spacer()
                Image(systemName: utility.symbol)
                    .font(
                        .system(
                            size: 25,
                            weight: .semibold,
                            design: .rounded
                        )
                    )
                    .foregroundColor(.accentColor)
            }
            .padding()
            Divider()
                .padding(.horizontal)
            HStack {
                Text("Command:")
                    .font(
                        .system(
                            size: 20,
                            weight: .medium,
                            design: .rounded
                        )
                )
                Spacer()
                ScrollView(.horizontal) {
                    Text(utility.command)
                        .font(
                            .system(
                                size: 15,
                                weight: .regular,
                                design: .monospaced
                            )
                        )
                        .textSelection(.enabled)
                        .fixedSize()
                }
            }
            .padding()
            HStack {
                Text("Asynchronous Result Fetching:")
                    .font(
                        .system(
                            size: 20,
                            weight: .medium,
                            design: .rounded
                        )
                    )
                Spacer()
                Text(utility.asyncFetch ? "On" : "Off")
                    .foregroundColor(utility.asyncFetch ? .blue : .red)
            }
            .padding()
            ZStack(alignment: logFile.isWhiteSpace ? .center : .topLeading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                if logFile.isWhiteSpace {
                    Text("Log File Is Empty")
                        .font(
                            .system(
                                size: 35,
                                weight: .black,
                                design: .monospaced
                            )
                        )
                        .textSelection(.enabled)
                } else {
                    ScrollView([.horizontal, .vertical]) {
                        Text(logFile)
                            .font(
                                .system(
                                    size: 15,
                                    weight: .light,
                                    design: .monospaced
                                )
                            )
                            .padding()
                    }
                }
            }
        }
        .padding()
        .toolbar {
            Button {
                run.toggle()
            } label: {
                Label(run ? "Stop" : "Run", systemImage: run ? "stop.fill" : "play.fill")
            }
        }
        .onReceive(timer) { _ in
            if run && utility.asyncFetch {
                logFile = ""
                utility.run(logFile: &logFile)
            }
        }
    }
}

struct UtilityRunner_Previews: PreviewProvider {
    static var previews: some View {
        UtilityRunner(
            father: .constant([]),
            logFile: "",
            utility: .init(command: "top")
        )
    }
}
