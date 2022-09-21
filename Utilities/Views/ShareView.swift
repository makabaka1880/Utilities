//
//  ShareView.swift
//  Utilities
//
//  Created by SeanLi on 2022/9/23.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

struct ShareView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    var item: Utility
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button("OK") {
                dismiss()
            }
            .foregroundColor(.accentColor)
            .buttonStyle(.plain)
            .padding()
            VStack {
                ScrollView([.vertical, .horizontal]) {
                    Text(item.rawValue)
                        .font(
                            .system(
                                size: 15,
                                weight: .regular,
                                design: .monospaced
                            )
                        )
                        .textSelection(.enabled)
                }
                let card = CardView(item: item)
                card
                Button {
                    let controller = NSSavePanel()
                    controller.allowedContentTypes = [.jpeg]
                    controller.message = "Save the card to disk"
                    controller.nameFieldStringValue = item.name
                    if controller.runModal() == .OK {
                        let data = card.saveImage()
                        try! data.write(to: controller.url!)
                    }
                } label: {
                    Label("Share", systemImage: "square.and.arrow.up")
                        .foregroundColor(.accentColor)
                }
                .buttonStyle(.plain)
                .padding()
            }
        }
    }
}

struct CardView: View {
    var item: Utility
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.thickMaterial)
                .padding()
            VStack {
                HStack {
                    Text(item.name)
                        .font(
                            .system(
                                size: 25,
                                weight: .semibold,
                                design: .rounded
                            )
                        )
                        .textSelection(.enabled)
                    Spacer()
                    Image(systemName: item.symbol)
                        .foregroundColor(.accentColor)
                        .font(
                            .system(
                                size: 25,
                                weight: .semibold,
                                design: .rounded
                            )
                        )
                        .textSelection(.enabled)
                }
                HStack {
                    Text(item.command)
                        .font(
                            .system(
                                size: 15,
                                weight: .regular,
                                design: .monospaced
                            )
                        )
                        .textSelection(.enabled)
                    .padding()
                    Spacer()
                    if item.asyncFetch {
                        Text("ASYNC")
                            .fontWeight(.black)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(40)
        }
    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView(item: .init())
    }
}

extension View {
    func saveImage() -> Data{
        let nsView = NSHostingView(rootView: self)
        let bitmapRep = nsView.bitmapImageRepForCachingDisplay(in: nsView.bounds)!
        bitmapRep.size = nsView.bounds.size
        nsView.cacheDisplay(in: nsView.bounds, to: bitmapRep)
        let data = bitmapRep.representation(using: .jpeg, properties: [:])!
        return data
    }
}

