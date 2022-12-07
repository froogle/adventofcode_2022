//
//  Day7.swift
//  adventofcode
//
//  Created by Peter Wright on 07/12/2022.
//

import Foundation
class Day7 : AdventDay {
    
    func execute() {
        let handler = InputHandler(
            path: "/Users/froogle/develops/adventofcode/adventofcode/inputs/day7_1"
        )
        
        var sizes = [String:Int]()
        var filePaths = [String]()
        var totalSize = 0
        handler.parse{ line in
            
            let words = line.split(separator: " ")
            if words[1] == "cd" {
                if words[2] == ".." {
                    _ = filePaths.popLast()
                } else {
                    filePaths.append( String(words[2]) )
                }
            } else if words[0] != "$" {
                let fileSize = Int(words[0]) ?? 0

                var qualifiedPath = "/"
                for filePath in filePaths {
                    qualifiedPath = "\(qualifiedPath)/\(filePath)"
                    sizes[qualifiedPath] = (sizes[qualifiedPath] ?? 0) + fileSize
                }
                totalSize += fileSize
            }
        }
        sizes["/"] = totalSize
        
        let maxUsed = 70000000 - 30000000
        let totalUsed = sizes["/"]!
        let needToFree = totalUsed - maxUsed
        
        var part1Answer = 0
        var part2Answer = 10000000000
        for key in sizes.keys {
            if sizes[key]! <= 100000 {
                part1Answer += sizes[key]!
            }
            
            if sizes[key]! >= needToFree {
                part2Answer = min( part2Answer, sizes[key]!)
            }
        }
        
        print(part1Answer)
        print(part2Answer)
        
    }
}
