//
//  Day2.swift
//  adventofcode
//
//  Created by Peter Wright on 02/12/2022.
//

import Foundation

class Day2 {
    // A = 1, B = 2, C = 3
    let scores: [String:Int] = [
        "A X" : 1 + 3,
        "A Y" : 2 + 6,
        "A Z" : 3 + 0,
        
        "B X" : 1 + 0,
        "B Y" : 2 + 3,
        "B Z" : 3 + 6,
        
        "C X" : 1 + 6,
        "C Y" : 2 + 0,
        "C Z" : 3 + 3,
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
        let handler = InputHandler(
            path: "/Users/froogle/develops/adventofcode/adventofcode/inputs/day2_1"
        )
        
        var totalScore = 0
        var totalStrategyScore = 0
        
        handler.parse() { line in
            totalScore += scores[line] ?? 0
            totalStrategyScore += scores[ strategy[line]! ] ?? 0
        }
        
        // Winning was 13809 and 12316
        print("Actual Score: " + String(totalScore))
        print("Strategy SCore: " + String(totalStrategyScore))
    }
}
