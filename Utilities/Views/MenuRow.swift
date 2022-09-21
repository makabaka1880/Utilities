//
//  MenuRow.swift
//  Utilities
//
//  Created by SeanLi on 2022/9/22.
//

import SwiftUI

struct MenuRow: View {
    @State var log: String = "New"
    @State var refresh: Bool = true
    var utility: Utility
    var body: some View {
        if refresh {
            HStack {
                Label(utility.name, systemImage: utility.symbol)
                ScrollView([.horizontal, .vertical]) {
                    Text(log)
                }
                .frame(height: 20)
                Spacer()
                Button {
                    utility.run(logFile: &log)
                    refresh.toggle()
                } label: {
                    Image(systemName: "play.fill")
                }
                .buttonStyle(.plain)
            }
        } else {
            HStack {
                Label(utility.name, systemImage: utility.symbol)
                ScrollView([.horizontal, .vertical]) {
                    Text(log)
                }
                .frame(height: 20)
                Spacer()
                Button {
                    utility.run(logFile: &log)
                    refresh.toggle()
                } label: {
                    Image(systemName: "play.fill")
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct MenuRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            MenuRow(log: "Test", utility: .init(command: "cd ~/; mkdir Test;"))
        }
    }
}
