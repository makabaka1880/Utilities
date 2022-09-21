//
//  isBlankSpace.swift
//  Utilities
//
//  Created by SeanLi on 2022/9/22.
//

import Foundation

extension String {
    var isWhiteSpace: Bool {
        return (self
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\t", with: "")
            .count) == 0
    }
}
