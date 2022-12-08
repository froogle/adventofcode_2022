//
//  Day5.swift
//  adventofcode
//
//  Created by Peter Wright on 05/12/2022.
//

// Yank all letters : [(A-Z)]+
// Yank all numbers : (\d)+
//for match in uniqueItemsInBackpack.matches(of: regex) {
//    let backpackItem = String(match.output.0)
//    if let priority = indexOf(searchTerm: backpackItem, inSource: priorities) {
//        totalScore += priority + 1
//    }
//}

import Foundation
class Day5 : AdventDay {
    private var stacks: [Stack<String>] = []
    private var orderedStacks: [Stack<String>] = []
    
    
    func execute() {

        for _ in 1...9 {
            stacks.append( Stack<String>() )
            orderedStacks.append(Stack<String>() )
        }
        
        var shuffleMode = false
        parse { line in
            addToStacks(line)
            
            if shuffleMode { processShuffleCommand(line) }
            if line.isEmpty {
                shuffleMode = true
                for stack in stacks {
                    print(stack.description)
                }
                print(">>>>")
            }
        }
        
        var topsOfAllCrates = ""
        for var stack in stacks {
            topsOfAllCrates += stack.pop()!
        }
        var topsOfOrderedCrates = ""
        for var orderedStack in orderedStacks {
            topsOfOrderedCrates += orderedStack.pop()!
        }
        print(topsOfAllCrates)
        print(topsOfOrderedCrates)
    }
    
    func addToStacks( _ line: String ) {
        let stacksRegex = /[(A-Z)0]+/
            .matchingSemantics(.graphemeCluster)
            .repetitionBehavior(.eager)
        
        var stackNumber = 0 
        for match in line.matches(of: stacksRegex) {
            let item = String(match.output)
            if item != "0" {
                stacks[ stackNumber ].inversePush( item )
                orderedStacks[ stackNumber ].inversePush( item )
            }
            stackNumber += 1
        }
    }
    
    
    func processShuffleCommand(_ line: String) {
        let commandsRegex = /(\d)+/
            .matchingSemantics(.graphemeCluster)
            .repetitionBehavior(.eager)
        
        let matches = line.matches(of: commandsRegex)
        
        let moveCount = String(matches[0].output.0)
        let from = String(matches[1].output.0)
        let to = String(matches[2].output.0)
        
        let fromIndex = Int(from)!
        let toIndex = Int(to)!
        
        for _ in 1...Int(moveCount)! {
            if let pop = stacks[ fromIndex - 1 ].pop() {
                stacks[ toIndex  - 1 ].push(pop)
            }
        }
        
        var tempStack = Stack<String>()
        for _ in 1...Int(moveCount)! {
            tempStack.push(orderedStacks[fromIndex - 1].pop()!)
        }
        for _ in 1...Int(moveCount)! {
            orderedStacks[ toIndex - 1].push( tempStack.pop()! )
        }
    }
    
    
    func shuffleStacks( move: Int, from: Int, to: Int)
    {
        for _ in 1...move {
            if let popValue = stacks[ from - 1 ].pop() {
                stacks[ to - 1 ].push(popValue)
            }
        }
    }
}
