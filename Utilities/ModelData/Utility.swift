//
//  Utility.swift
//  Utilities
//
//  Created by SeanLi on 2022/9/21.
//

import Foundation

struct Utility: Codable, Hashable, Identifiable {
    let id: UUID
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(Utility.self, from: data)
        else { return nil }
        self.name = result.name
        self.asyncFetch = result.asyncFetch
        self.symbol = result.symbol
        self.command = result.command
        self.id = result.id
    }
    public init(name: String? = nil, command: String? = nil, symbol: String? = nil, asyncFetch: Bool? = nil) {
        self.name = name ?? "New Utility"
        self.command = command ?? #"echo "Command "# + (name ?? "New Utility") + #" Executed""#
        self.symbol = symbol ?? symbols.randomElement()!
        self.asyncFetch = asyncFetch ?? true
        self.id = .init()
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.command = try container.decode(String.self, forKey: .command)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.asyncFetch = try container.decode(Bool.self, forKey: .asyncFetch)
        self.id = try container.decode(UUID.self, forKey: .id)
    }
    public init?(_ script: URL) {
        guard let content = try? String(contentsOf: script) else {
            return nil
        }
        var scriptText = ""
        for i in content.split(separator: "\n") {
            var j: String = String(i)
            while i.first == " " || i.first == "\t" {
                j.removeFirst()
            }
            while i.last == " " || i.last == "\t" {
                j.removeLast()
            }
            if j.first == "#" {
                continue
            }
            scriptText += (j + "; ")
        }
        self.name = script.deletingPathExtension().lastPathComponent
        self.command = scriptText
        self.symbol = symbols.randomElement()!
        self.asyncFetch = true
        self.id = .init()
    }
    public var rawValue: String {
        var encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return ""
        }
        return result
    }
    var name: String
    var command: String
    var symbol: String
    var asyncFetch: Bool
    @discardableResult
    func run(launchPath: String? = nil) -> String {
        let output = Utilities.run(command: command)
        return output
    }
    func run(logFile: inout String, launchPath: String? = nil, stripeDeadCharacters: Bool? = nil) {
        var output = Utilities.run(command: command)
        if stripeDeadCharacters ?? false {
            while output.last == "\n" {
                output.removeLast()
            }
        }
        logFile += output
    }
}

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else { return nil }
        self = result
    }
    
    public var rawValue: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

@discardableResult
func run(launchPath: String? = nil, command: String) -> String {
    let task = Process()
    let pipe = Pipe()
    
    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.launchPath = launchPath ?? "/bin/zsh/"
    task.launch()
    let data = try? pipe.fileHandleForReading.readToEnd()!
    return String(data: data!, encoding: .utf8)!
}
