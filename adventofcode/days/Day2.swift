//
//  Day2.swift
//  adventofcode
//
//  Created by Peter Wright on 02/12/2022.
//

import Foundation

class Day2 : AdventDay {
    // A = 1, B = 2, C = 3
    let scores: [String:Int] = [
        "A X" : 1 + 3, // 2
        "A Y" : 2 + 6, // 3
        "A Z" : 3 + 0, // 4
        
        "B X" : 1 + 0, // 3
        "B Y" : 2 + 3, // 4
        "B Z" : 3 + 6, // 5
        
        "C X" : 1 + 6, // 4
        "C Y" : 2 + 0, // 5
        "C Z" : 3 + 3, // 6
    ]
    

    // X = Lose, Y = Draw, Z = Win
    let strategy: [String:String] = [
        "A X" : "A Z",
        "A Y" : "A X",
        "A Z" : "A Y",
        
        "B X" : "B X",
        "B Y" : "B Y",
        "B Z" : "B Z",
        
        "C X" : "C Y",
        "C Y" : "C Z",
        "C Z" : "C X",
    ]
    
    
    func execute() {

        var totalScore = 0
        var totalStrategyScore = 0
        
        parse() { line in
            totalScore += scores[line] ?? 0
            totalStrategyScore += scores[ strategy[line]! ] ?? 0
        }
        
        print("Actual Score: " + String(totalScore))
        print("Strategy Score: " + String(totalStrategyScore))
    }
}
