//
//  Parser.swift
//  RSSReeder
//
//  Created by Sergey Shinkarenko on 18.06.21.
//

import Foundation

let json = ""
class Parser {
    static let singletone = Parser()
    
    var savedMonkeys: Monkeys?
    private init() {}

    func parseNamesFromJSON() -> Monkeys? {
        if let saved = savedMonkeys {
            return saved
        }
        let decoder = JSONDecoder()
        
        guard let path = Bundle.main.url(forResource: "JSON", withExtension: "json"),
              let jsonData = try? String(contentsOf: path).data(using: .utf8),
              let group: Monkeys = try? decoder.decode(Monkeys.self, from: jsonData) else {
            print("Error here")
            return nil
        }
        savedMonkeys = group
        return group
    }
}
