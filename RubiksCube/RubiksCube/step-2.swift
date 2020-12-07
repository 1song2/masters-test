//
//  step-2.swift
//  RubiksCube
//
//  Created by Song on 2020/12/07.
//

import Foundation

struct FlatCube {
    let originalCube: [[String]] = [["R", "R", "W"], ["G", "C", "W"], ["G", "B", "B"]]
    
    func printCube() {
        for index in 0..<originalCube.count {
            for subIndex in 0..<originalCube[index].count {
                print(originalCube[index][subIndex], terminator: " ")
            }
            print()
        }
    }
}
