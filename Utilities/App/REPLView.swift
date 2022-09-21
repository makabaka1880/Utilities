//
//  REPLView.swift
//  Utilities
//
//  Created by SeanLi on 2022/9/25.
//

import SwiftUI

let interactive = [
    "zsh",
    "bash",
    "vi",
    "vim",
    "top"
]
struct REPLView: View {
    @AppStorage("launch") var launchPath: String = "/bin/zsh"
    @State var context: Text = Text("SHELL STARTED AT ")
        .fontWeight(.black) + Text("\(Date().ISO8601Format())\n")
        .foregroundColor(.accentColor)
        .fontWeight(.bold)
    @State var command: String = ""
    var body: some View {
        VStack {
            ScrollView([.horizontal, .vertical]) {
                HStack {
                    context
                    Spacer()
                }
                .frame(width: 500)
                .padding()
            }
            .frame(width: 500, height: 300)
            .border(.gray)
            HStack {
                TextField("@\(launchPath)", text: $command)
                    .onSubmit {
                        runCommand()
                    }
                    .textFieldStyle(.plain)
                Button {
                    runCommand()
                } label: {
                    Label("Send", systemImage: "arrow.right")
                        .foregroundColor(.accentColor)
                }
                .buttonStyle(.plain)
            }
            .padding()
        }
        .onAppear {
            newPrompt()
        }
    }
    func newPrompt() {
        var new: Text {
            let new = Text("Utilities REPL@*\(Host.current().name!)* \(launchPath)")
                .fontWeight(.bold)
            let prompt = Text(" > ")
            return context + new + prompt
        }
        context = new
    }
    func runCommand() {
        if interactive.contains(command
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: "\n", with: "")) {
            var new: Text {
                let commnd = Text(" \(command)\n")
                let cont: Text = Text("*The REPL have not yet supported `\(command)` inside the environment.*\n")
                    .foregroundColor(.red)
                return context + commnd + cont
            }
            context = new
            newPrompt()
        } else {
            var new: Text {
                let commnd = Text(" \(command)\n")
                let cont: Text = Text(run(command: command))
                return context + commnd + cont
            }
            context = new
            newPrompt()
        }
    }
}

struct REPLView_Previews: PreviewProvider {
    static var previews: some View {
        REPLView()
    }
}
