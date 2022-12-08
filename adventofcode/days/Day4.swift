//
//  Day4.swift
//  adventofcode
//
//  Created by Peter Wright on 04/12/2022.
//

import Foundation
class Day4 : AdventDay {
    
    func execute() {

        
        var overlaps = 0
        var partialOverlaps = 0
        parse { line in
            let elfSections = line.split(separator: ",")
            
            var sectionPair = SectionPair()
            sectionPair.add(section: String(elfSections[0]))
            sectionPair.add(section: String(elfSections[1]))
            
            if sectionPair.overlap { overlaps += 1}
            if sectionPair.partialOverlap { partialOverlaps += 1}
        }
        
        print("The number of overlapping sections is \(overlaps)")
        print("The number of partially overlapping sections is \(partialOverlaps)")
    }
}


struct SectionPair {
    private var sections: [Section] = [Section]()
    // 3-6,3-8
    // 3-8, 4-8
    var overlap : Bool {
        let sortedSectionsByArea = sections.sorted(by: {$0.area < $1.area})
    
        let overlap = (
            sortedSectionsByArea[0].lower >= sortedSectionsByArea[1].lower &&
            sortedSectionsByArea[0].upper <= sortedSectionsByArea[1].upper
        )
        
        return overlap
    }
    
    var partialOverlap : Bool {
        let sortedSectionsByArea = sections.sorted(by: {$0.area < $1.area})
        
        let partialOverlap = (
            
            (
                sortedSectionsByArea[0].lower >= sortedSectionsByArea[1].lower && sortedSectionsByArea[0].lower <= sortedSectionsByArea[1].upper
            )
            ||
            (
                sortedSectionsByArea[0].upper >= sortedSectionsByArea[1].lower && sortedSectionsByArea[0].upper <= sortedSectionsByArea[1].upper
            )
        )
        
        return partialOverlap
    }
    
    mutating func add( section: String ) {
        let limits = section.split(separator: "-")
        
        let lowerBoundary = Int(limits[0]) ?? 0
        let upperBoundary = Int(limits[1]) ?? 0
        
        sections.append( Section(lower: lowerBoundary , upper: upperBoundary))
    }
}

struct Section {
    var lower: Int
    var upper: Int
    
    init(lower: Int, upper: Int) {
        if lower <= upper {
            self.lower = lower
            self.upper = upper
        } else {
            self.lower = upper
            self.upper = lower
        }
    }
    
    var area: Int {
        return upper - lower
    }
}

