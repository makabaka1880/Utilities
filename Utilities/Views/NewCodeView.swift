//
//  NewCodeView.swift
//  Utilities
//
//  Created by SeanLi on 2022/9/24.
//

import SwiftUI

extension NSTextView {
    open override var frame: CGRect {
        didSet {
            self.isAutomaticQuoteSubstitutionEnabled = false
        }
    }
}

struct NewCodeView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    @Binding var utilities: [Utility]
    @State var utility: Utility? = .init(name: "Loading", command: "", symbol: "clock.arrow.circlepath", asyncFetch: false)
    @State var text: String = """
    {
        "asyncFetch": true,
        "symbol": "\(symbols.randomElement()!)",
        "name": "New",
        "command": "ifconfig en0"
    }
    """
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.accentColor)
                }
                .buttonStyle(.plain)
                .padding()
                Spacer()
                HStack(alignment: .center) {
                    Text("New Utility via JSON RawValue")
                        .font(
                            .system(
                                size: 35,
                                weight: .medium,
                                design: .default
                            )
                        )
                        .padding()
                    Circle()
                        .size(
                            CGSize(width: 10, height: 10))
                        .fill(utility == nil ? .red : .green)
                        .fixedSize()
                }
                Spacer()
                Button {
                    utilities.append(utility!)
                    dismiss()
                } label: {
                    Text("OK")
                        .foregroundColor(.accentColor)
                }
                .buttonStyle(.plain)
                .disabled(utility == nil)
                .padding()
            }
            Text("Code")
                .foregroundColor(.gray)
                .padding()
            TextEditor(text: $text)
                .font(
                    .system(
                        size: 15,
                        weight: .light,
                        design: .monospaced
                    )
                )
                .disableAutocorrection(true)
                .padding()
                .background(.white)
                .cornerRadius(10)
                .padding()
                .onChange(of: text) { item in
                    utility = .init(rawValue: text.replacingOccurrences(of: "“", with: "\""))
                    
                    print(text)
                    print(utility)
                }
                .task {
                    utility = .init(rawValue: text)
                }
            Text("Preview")
                .foregroundColor(.gray)
                .padding()
            CardView(item: utility ?? .init(name: "ERROR", command: "ERROR", symbol: "xmark.square.fill", asyncFetch: false))
        }
    }
}

struct NewCodeView_Previews: PreviewProvider {
    static var previews: some View {
        NewCodeView(utilities: .constant([]))
            .frame(width: 750, height: 600)
    }
}
