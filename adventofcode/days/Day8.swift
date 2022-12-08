//
//  Day8.swift
//  adventofcode
//
//  Created by Peter Wright on 08/12/2022.
//

import Foundation

class Day8 : AdventDay {

    private var lines = [String]()
    
    private var forestWidth = 0
    private var forestHeight = 0
    private var forest = [Int]()
    
    func execute() {
        parse { line in
            lines.append(line)
        }
        buildForest()
        countVisibleTrees()
    }
    
    fileprivate func buildForest() {
        forestWidth = lines[0].count
        forestHeight = lines.count
    
        for line in lines {
            for char in line {
                forest.append(Int(String(char))!)
            }
        }
    }
    
    fileprivate func countVisibleTrees() {
        
        var visibleTrees = 0
        
        for column in 0..<forestWidth {
            for row in 0..<forestHeight {
                if treeIsVisible( column, row ) { visibleTrees += 1}
            }
        }
        
        print("The number of trees visible from outside the grid is \(visibleTrees)")
    }
    
    fileprivate func treeIsVisible(_ x:Int, _ y:Int) -> Bool {
        // x = column, y = row
        if ( x == 0 || x == forestWidth-1 || y == 0 || y == forestHeight-1) { return true}
        
        let currentTreeHeight = forest[ (y * forestWidth) + x]
        
        
        var rowHeights = [Int]()
        for row in 0..<forestHeight {
            rowHeights.append( forest[ (row * forestWidth) + x])
        }
        
        var columnHeights = [Int]()
        for column in 0..<forestWidth {
            columnHeights.append( forest[ (y * forestWidth) + column])
        }
        
    
        var treeHeights = [Int]()
        treeHeights.append( columnHeights[0..<x].max() ?? 0)
        treeHeights.append( columnHeights[x+1..<forestWidth].max() ?? 0)
        
        treeHeights.append( rowHeights[0..<y].max() ?? 0)
        treeHeights.append( rowHeights[y+1..<forestHeight].max() ?? 0)
        
        let surroundingTreeHeightMin = treeHeights.min() ?? 0
        return surroundingTreeHeightMin < currentTreeHeight
    }
}
