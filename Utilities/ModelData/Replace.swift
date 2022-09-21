//
//  Replace.swift
//  Utilities
//
//  Created by SeanLi on 2022/9/23.
//

import Foundation

func replace(_ sequence: inout [Utility], item: Utility, with replace: Utility) {
//    let raw = sequence.rawValue
//    print(raw)
//    let rawReplaced = raw.replacingOccurrences(of: item.rawValue, with: replace.rawValue)
//    print(raw.contains(item.rawValue))
//    print(item.rawValue, replace.rawValue)
//    print(rawReplaced)
//    sequence = [Utility].init(rawValue: rawReplaced)!
//    print(sequence.rawValue)
    for i in sequence {
        if i == item {
            let index = sequence.firstIndex(of: item)!
            sequence.removeAll { item in
                // (item.name == i.name) && (item.command == i.command) && (item.symbol == i.symbol) && (item.symbol == i.symbol) && (item.asyncFetch == item.asyncFetch)
                item == i
            }
            sequence.insert(replace, at: index)
        }
    }
//    sequence = [Utility].init(rawValue: sequence.rawValue.replacingOccurrences(of: item.rawValue, with: replace.rawValue))!
//    print(sequence)
}

var a = """
{
  "asyncFetch" : true,
  "symbol" : "building.columns.fill",
  "name" : "Disk Snapshot",
  "command" : "df \"
}
[
  {
    "asyncFetch" : true,
    "symbol" : "building.columns.fill",
    "name" : "Disk Snapshot",
    "command" : "df \"
  },
  {
    "asyncFetch" : true,
    "symbol" : "globe.americas.fill",
    "name" : "Network at en0",
    "command" : "ifconfig en0"
  }
]
"""
