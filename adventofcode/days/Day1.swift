//
//  Day1.swift
//  adventofcode
//
//  Created by Peter Wright on 01/12/2022.
//

import Foundation

class Day1 : AdventDay{
    
    func execute() {
        
        var elves : [Int] = []
        
        var caloriesTotal = 0
        
        parse() { line in
            if line.isEmpty {
                elves.append(caloriesTotal)
                caloriesTotal = 0
            } else { caloriesTotal += Int(line) ?? 0 }
        }
        
        let sortedElves = elves.sorted().reversed()
        
        var totalScore = 0
        for score in sortedElves.prefix(3) {
            totalScore += Int(score)
            print(String(score))
        }
        print("The total is " + String(totalScore))
    }
}
