//
//  Day3.swift
//  adventofcode
//
//  Created by Peter Wright on 03/12/2022.
//
import Foundation


class Day3 : AdventDay  {
    func execute() {
        let handler = InputHandler(
            path: "/Users/froogle/develops/adventofcode/adventofcode/inputs/day3_1"
        )
        
        var priorities = "abcdefghijklmnopqrstuvwxyz"
        priorities = priorities + priorities.uppercased()
        
        let regex = /(.)(?=.*\1)/
            .matchingSemantics(.graphemeCluster)
            .repetitionBehavior(.eager)
        
        var elfCounter = 0
        var totalScore = 0
        var totalGroupScore = 0
        
        var groupItems = [Substring.Element: Int]()
        handler.parse { line in
            let uniqueItemsInBackpack = line.prefix(line.count / 2).replacing(regex, with: "") + line.suffix(line.count / 2).replacing(regex, with:"")
            
            for match in uniqueItemsInBackpack.matches(of: regex) {
                let backpackItem = String(match.output.0)
                if let priority = indexOf(searchTerm: backpackItem, inSource: priorities) {
                    totalScore += priority + 1
                }
            }
            
            for item in uniqueItemsInBackpack {
                groupItems[item] = 1 + (groupItems[item] ?? 0)
            }
            
            
            
            elfCounter = (elfCounter + 1) % 3
            if elfCounter == 0 {
                var groupPriority = 0
                // Sum all values where count is greater than 1
                for (backpackItem, itemCount) in groupItems {
                    if ( itemCount == 3 ) {
                        groupPriority += (indexOf(searchTerm: String(backpackItem), inSource: priorities) ?? 0) + 1
                    }
                }
                groupItems = [Substring.Element: Int]()
                totalGroupScore += groupPriority
            }
        }
        
        print("The total value of all the priorities is \(totalScore)")
        print("The total group priorities is \(totalGroupScore)")
    }
    
    
    func indexOf( searchTerm: String, inSource: String) -> Int? {
        
        var index: Int = 0
        
        if let range: Range<String.Index> = inSource.range(of: searchTerm) {
            index = inSource.distance(from: inSource.startIndex, to: range.lowerBound)
            return index
        }
        return nil
    }
    
    
}
