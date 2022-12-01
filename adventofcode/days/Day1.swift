//
//  Day1.swift
//  adventofcode
//
//  Created by Peter Wright on 01/12/2022.
//

import Foundation

class Day1 {
    
    func execute() {
        let inputPath = "/Users/froogle/develops/adventofcode/adventofcode/inputs/day1_1"
        
        guard let file = freopen(inputPath, "r", stdin) else {
            print("I was unable to open the input file")
            return
        }
        defer {
            fclose(file)
        }
        
        
        var calories : [Int] = []
        var currentScore = 0
        while let line = readLine() {
            if line.isEmpty {
                calories.append(currentScore)
                currentScore = 0
            } else {
                currentScore += Int(line) ?? 0
            }
        }
        calories.append(currentScore)
        
        let sortedCalories = calories.sorted()
        
        for score in sortedCalories {
            print(String(score))
        }
    }
    
}
