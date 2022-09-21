//
//  HelpView.swift
//  Utilities
//
//  Created by SeanLi on 2022/9/22.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        PDFKitView(url: Bundle.main.url(forResource: "Test", withExtension: "pdf", subdirectory: nil)!)
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
