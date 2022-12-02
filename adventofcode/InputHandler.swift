//
//  InputHandler.swift
//  adventofcode
//
//  Created by Peter Wright on 02/12/2022.
//

import Foundation
class InputHandler {
    private let inputFile: String
    
    init(path: String) {
        inputFile = path
    }
    
    func parse( parser: (_ line: String) -> Void ) {
        guard let file = freopen(inputFile, "r", stdin) else {
            print("I was unable to open the input file")
            return
        }
        defer {
            fclose(file)
        }
        
        while let line = readLine() {
            parser(line)
        }
    }
}
