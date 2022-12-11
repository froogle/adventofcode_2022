//
//  Day11.swift
//  adventofcode
//
//  Created by Peter Wright on 11/12/2022.
//

import Foundation
class Day11 : AdventDay {
    
    var monkeys = [Monkey]()
    
    func execute() {
        
        var monkeyLine = ""
        parse() { line in
            if  line.isEmpty {
                monkeys.append( Monkey(monkeyLine: monkeyLine ))
                monkeyLine = ""
            } else {
                monkeyLine = "\(monkeyLine)\(line.trimmingCharacters(in: .whitespacesAndNewlines)):"
            }
        }
        monkeys.append( Monkey(monkeyLine: monkeyLine ))
        
        // Process the monkeys - 34 years of writing code professionally and never once have I written that
        var rounds = 0
        while rounds < 20 {
            for  monkey in monkeys {
                while monkey.canThrowItem() {
                    monkeys[monkey.monkeyToThrowTo].catchItem(monkey.itemToThrow)
                }
            }
            rounds += 1
        }
        
        
        let sortedMonkeys = monkeys.sorted { $1.inspectionCount < $0.inspectionCount}
        for monkey in sortedMonkeys {
            print(monkey.inspectionCount)
        }
        
        print("Question 1: The total monkey business is \(sortedMonkeys[0].inspectionCount * sortedMonkeys[1].inspectionCount)")
        
    }
}

class Monkey {
     var items = [Int]()
    private var itemOperator = ""
    private var itemOperand = ""
    private var itemDivisor = 0
    
    private var trueMonkey = 0
    private var falseMonkey = 3
    
    var monkeyToThrowTo = 0
    var itemToThrow = 0
    
    var inspectionCount = 0
    
    init(monkeyLine: String) {
        let commands = monkeyLine.split(separator: ":")
        
        // Set the initial items list
        for item in commands[2].split(separator: ",") {
            let newItem = String(item).trimmingCharacters(in: .whitespacesAndNewlines)
            items.append(Int(newItem) ?? 0)
        }
        
        // Work out the operation
        let operationBits = commands[4].split(separator: " ")
        itemOperator = String(operationBits[3])
        itemOperand = String(operationBits[4])
        
        itemDivisor = Int(commands[6].split(separator: " ")[2]) ?? 0
        
        trueMonkey = Int(commands[8].split(separator: " ")[3]) ?? 0
        falseMonkey = Int(commands[10].split(separator: " ")[3]) ?? 0
    }
    
     func canThrowItem() -> Bool {
        if items.isEmpty { return false }
        
        let operand1 = items.remove(at: 0)
        var operand2 = operand1
        if itemOperand != "old" { operand2 = Int(itemOperand) ?? 0 }
        
        var new = 0
        if itemOperator == "+" {
            new = operand1 + operand2
        } else {
            new = operand1 * operand2
        }
        
        new = new / 3
        
        if ( new % itemDivisor ) == 0 {
            monkeyToThrowTo = trueMonkey
        } else {
            monkeyToThrowTo = falseMonkey
        }
        itemToThrow = new
        
        inspectionCount += 1
        
        return true
    }
    
     func catchItem(_ item: Int) {
        items.append( item )
    }
}
