//
//  MenuView.swift
//  Utilities
//
//  Created by SeanLi on 2022/9/21.
//

import SwiftUI

struct MenuView: View {
    @AppStorage("UtilList") var utilities: [Utility] = []
    var body: some View {
        List {
            
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(
            utilities: [.init()]
        )
    }
}
