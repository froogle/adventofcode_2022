//
//  Stack.swift
//  adventofcode
//
//  Created by Peter Wright on 05/12/2022.
//

import Foundation
struct Stack<T>  {
    var items: [T] = []
    
    var description: String {
        return "---- top of stack ----\n" +
        items.map({ "\($0)" }).joined(separator: "\n") +
        "\n------ bottom of stack -----\n"
    }

    var size: Int {
        return items.count
    }
    
    mutating func inversePush(_ item: T ) {
        self.items.append( item )
    }
    
    mutating func push(_ item: T ) {
        self.items.insert(item, at: 0 )
    }
    
    @discardableResult
    mutating func pop()  -> T? {
        if items.isEmpty { return nil }
        return self.items.removeFirst()
    }
    
    func peek() -> T? {
        return self.items.first
    }
}
