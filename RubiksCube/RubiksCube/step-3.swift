//
//  step-3.swift
//  RubiksCube
//
//  Created by Song on 2020/12/08.
//

import Foundation

struct RubiksCube {
    var cube: [[[String]]] = [
        [["B", "B", "B"], ["B", "B", "B"], ["B", "B", "B"]],
        [["W", "W", "W"], ["W", "W", "W"], ["W", "W", "W"]],
        [["O", "O", "O"], ["O", "O", "O"], ["O", "O", "O"]],
        [["G", "G", "G"], ["G", "G", "G"], ["G", "G", "G"]],
        [["Y", "Y", "Y"], ["Y", "Y", "Y"], ["Y", "Y", "Y"]],
        [["R", "R", "R"], ["R", "R", "R"], ["R", "R", "R"]],
    ]
    
    func printCube() {
        for index in 0..<cube[0].count {
            print("                ", terminator: "")
            printOneSide(outerIndex: 0, index: index)
            print()
        }
        print()
        for index in 0...2 {
            for outerIndex in 1...4 {
                print(" ", terminator: "")
                printOneSide(outerIndex: outerIndex, index: index)
                print("   ", terminator: "")
            }
            print()
        }
        print()
        for index in 0..<cube[5].count {
            print("                ", terminator: "")
            printOneSide(outerIndex: 5, index: index)
            print()
        }
    }
    
    func printOneSide(outerIndex: Int, index: Int) {
        for innerIndex in 0..<cube[outerIndex][index].count {
            print(cube[outerIndex][index][innerIndex], terminator: " ")
        }
    }
}
