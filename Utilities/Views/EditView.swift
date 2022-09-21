//
//  EditView.swift
//  Utilities
//
//  Created by SeanLi on 2022/9/23.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    @Binding var father: [Utility]
    @State var utility: Utility = .init()
    @State var original: Utility
    var body: some View {
        VStack {
            HStack {
                TextField("", text: $utility.name)
                    .textFieldStyle(.plain)
                    .font(
                        .system(
                            size: 25,
                            weight: .semibold,
                            design: .rounded
                        )
                    )
                Spacer()
                PopupButton(padding: 10) {
                    LazyHGrid(rows: .init(repeating: GridItem(.flexible(minimum: 100, maximum: 100)), count: 5)) {
                        ForEach(symbols, id: \.hashValue) { item in
                            Image(systemName: item)
                                .font(
                                    .system(
                                        size: 25,
                                        weight: .semibold,
                                        design: .rounded
                                    )
                                )
                                .foregroundColor(.accentColor)
                                .drawingGroup()
                                .onTapGesture {
                                    utility.symbol = item
                                }
                        }
                    }
                } label: {
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
            }
            .padding()
            Divider()
                .padding(.horizontal)
            HStack {
                Toggle(isOn: $utility.asyncFetch) {
                    Text("Asynchronous Result Fetching")
                        .font(
                            .system(
                                size: 20,
                                weight: .medium,
                                design: .rounded
                            )
                    )
                        .fixedSize()
                    Spacer()
                }
                .toggleStyle(.switch)
            }
            .padding()
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
                    TextField("Command", text: $utility.command)
                        .textFieldStyle(.plain)
                        .multilineTextAlignment(.trailing)
                        .font(
                            .system(
                                size: 15,
                                weight: .regular,
                                design: .monospaced
                            )
                        )
                }
                .fixedSize()
            }
            .padding()
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .font(
                            .system(
                                size: 25,
                                weight: .medium,
                                design: .rounded
                            )
                        )
                        .foregroundColor(.accentColor)
                        .padding()
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 10
                            )
                            .fill(Color.white)
                        )
                }
                .buttonStyle(.plain)
                .padding()
                Button {
                    replace(&father, item: original, with: utility)
                    dismiss()
                } label: {
                    Text("OK")
                        .font(
                            .system(
                                size: 25,
                                weight: .medium,
                                design: .rounded
                            )
                        )
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 10
                            )
                            .fill(Color.accentColor)
                        )
                }
                .buttonStyle(.plain)
                .padding()
            }
        }
        .onAppear {
            utility = original
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(father: .constant([]), original: .init())
    }
}
