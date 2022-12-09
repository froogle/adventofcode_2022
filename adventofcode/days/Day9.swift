//
//  Day9.swift
//  adventofcode
//
//  Created by Peter Wright on 09/12/2022.
//

import Foundation

class Day9 : AdventDay {
    private var knots:[CGPoint] = [CGPoint]()
    private var tail:CGPoint = CGPoint(x:0, y:0)
    
    private var tailPositions = [CGPoint]()
    
    func execute() {
        for _ in 0..<10 {
            knots.append( CGPoint(x:0, y:0))
        }
        parse { line in
            let components = line.split(separator:" ")
            moveHead(direction: String(components[0]), value: String(components[1]))
        }
        print("The tail travels to \(tailPositions.count + 1) locations")
    }
    
    fileprivate func updateTail(knot: Int) {
        let head = knots[knot-1]
        var tail = knots[knot]
        
        var xdiff = head.x - tail.x
        var ydiff = head.y - tail.y
        
        
        while abs(xdiff) > 1 || abs(ydiff) > 1 {
            let xOffset = head.x == tail.x ? 0: xdiff / abs(xdiff)
            let yOffset = head.y == tail.y ? 0: ydiff / abs(ydiff)
            
            tail = CGPoint( x: tail.x + xOffset, y: tail.y + yOffset )
            if knot == 9 {
                recordTailPosition( tail )
            }
            
            xdiff = head.x - tail.x
            ydiff = head.y - tail.y
        }
        
        knots[knot] = tail
        
    }
    
    fileprivate func recordTailPosition( _ position: CGPoint ) {
        if tailPositions.first(where: {$0.x == position.x && $0.y == position.y }) == nil {
            tailPositions.append(position)
        }
    }
    
    fileprivate func moveHead( direction: String, value: String)  {
        var numericValue = Double(value) ?? 0
        
        while numericValue > 0 {
            var head = knots[0]
            //TODO: Loop through each stage of movement, updating tails every single time.111
            switch direction {
            case "L":
                head =  CGPoint( x:head.x - 1, y:head.y )
            case "R":
                head =  CGPoint( x:head.x + 1, y:head.y )
            case "U":
                head =  CGPoint( x:head.x, y:head.y + 1)
            case "D":
                head = CGPoint( x:head.x, y:head.y - 1 )
            default:
                break
            }
            knots[0] = head
            for i in 1..<10 {
                updateTail(knot: i)
            }
            numericValue = numericValue - 1
        }
    }
}
