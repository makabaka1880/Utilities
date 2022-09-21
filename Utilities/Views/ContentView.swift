//
//  ContentView.swift
//  Utilities
//
//  Created by SeanLi on 2022/9/21.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("clock") var clock: Double = 0.1
    @AppStorage("launch") var launchPath: String = "/bin/zsh"
    @Binding var utilities: [Utility]
    @State var newItem: Utility = .init()
    @State var showNew: Bool = false
    @State var showCodeEdit: Bool = false
    @State var showError: Bool = false
    @State var error: String = "Unkwon Error"
    var body: some View {
        NavigationView {
            List(utilities) { utility in
                NavigationLink {
                    UtilityRunner(father: $utilities, utility: utility)
                } label: {
                    HStack {
                        Label(utility.name, systemImage: utility.symbol)
                        Spacer()
                        if utility.asyncFetch {
                            Text("ASYNC")
                                .font(.system(size: 7))
                                .fontWeight(.black)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .contextMenu {
                    Button {
                        utilities.removeAll { $0 == utility }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                .swipeActions {
                    Button(role: .destructive) {
                        utilities.removeAll { $0 == utility }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .toolbar {
                Menu {
                    Button {
                        newItem = .init()
                        showNew.toggle()
                    } label: {
                        Label("New", systemImage: "plus")
                    }
                    Button {
                        let controller = NSOpenPanel()
                        controller.allowedContentTypes = [.shellScript, .plainText, .text]
                        controller.message = "Choose a script (.sh, .txt or plain text)"
                        if controller.runModal() == .OK {
                            if let
                                new = Utility(controller.url!) {
                                newItem = new
                                showNew.toggle()
                            } else {
                                error = "Shell Invalid"
                                showError.toggle()
                            }
                        }
                    } label: {
                        Label("Script", systemImage: "terminal.fill")
                    }
                    Button {
                        showCodeEdit.toggle()
                    } label: {
                        Label("JSON RawValue", systemImage: "curlybraces")
                    }
                } label: {
                    Label("New...", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showNew) {
            NewCommandView(father: $utilities, utility: newItem)
        }
        .sheet(isPresented: $showCodeEdit) {
            NewCodeView(utilities: $utilities)
        }
        .alert("Error", isPresented: $showError) {
            Text(error)
        }
        .navigationTitle("Utilities")
        .navigationSubtitle("Clock \(UInt(clock*1000)) ms @ \(launchPath)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(utilities: .constant([.init()]))
    }
}
