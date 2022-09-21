//
//  SheetButton.swift
//  Utilities
//
//  Created by SeanLi on 2022/9/22.
//

import SwiftUI

struct SheetButton<Content, Label>: View where Content: View, Label: View {
    var padding: CGFloat?
    var showDismissButton: Bool
    var dismissString: String
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
            .sheet(isPresented: $showPopover) {
                content
                    .padding(padding ?? 0)
            }
    }
    
    init(padding: CGFloat? = nil, showDismissButton: Bool? = nil, dismissButtonLabel: String? = nil, @ViewBuilder content: () -> Content, @ViewBuilder label: () -> Label) {
        self.padding = padding
        self.showDismissButton = showDismissButton ?? true
        self.dismissString = dismissButtonLabel ?? "Dismiss"
        self.content = content()
        self.label = label()
    }
}

struct SheetButton_Previews: PreviewProvider {
    static var previews: some View {
        SheetButton(padding: 5) {
            Text("Test")
        } label: {
            Label("Test", systemImage: "hammer.fill")
                .foregroundColor(.accentColor)
        }
        .padding()
    }
}
