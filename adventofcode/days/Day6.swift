//
//  Day6.swift
//  adventofcode
//
//  Created by Peter Wright on 06/12/2022.
//

import Foundation
class Day6 : AdventDay {


    func execute() {
        
        parse{ line in
            
            findMarker(line, length: 4)
            findMarker(line, length: 14)
        }
    }
   
    
    func findMarker(_ line: String, length: Int) {
        var i = 0
        
        while i < line.count-length {
            let markerStartIndex = line.index(line.startIndex, offsetBy: i)
            let markerEndIndex = line.index(markerStartIndex, offsetBy: length)
            let markerRange:Range<String.Index> = markerStartIndex..<markerEndIndex
            
            let marker = line[markerRange]
            
            var match = true
            
            for char in marker {
                if marker.firstIndex(of: char) != marker.lastIndex(of: char) {
                    // i needs to be updated to the position after the first index
                    let index: Int = marker.distance(from: marker.startIndex, to: marker.firstIndex(of: char)!)
                    i = i + index + 1
                    match = false
                    break
                }
            }
            if match {
                print("Position after marker is \(i+length).")
                return
            }
        }
    }
    
}


