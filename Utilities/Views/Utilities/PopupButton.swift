//
//  PopupButton.swift
//  Utilities
//
//  Created by SeanLi on 2022/9/22.
//

import SwiftUI

struct PopupButton<Content, Label>: View where Content: View, Label: View {
    var padding: CGFloat?
    var content: Content
    var label: Label
    @State private var showPopover: Bool = false
    var body: some View {
        Button {
            showPopover.toggle()
        } label: {
            label
        }
        .buttonStyle(.plain)
            .popover(isPresented: $showPopover) {
                content
                    .padding(padding ?? 0)
            }
    }
    
    init(padding: CGFloat? = nil, @ViewBuilder content: () -> Content, @ViewBuilder label: () -> Label) {
        self.padding = padding
        self.content = content()
        self.label = label()
    }
}

struct PopupButton_Previews: PreviewProvider {
    static var previews: some View {
        PopupButton(padding: 5) {
            Text("Test")
        } label: {
            Label("Test", systemImage: "hammer.fill")
                .foregroundColor(.accentColor)
        }
        .padding()
    }
}
