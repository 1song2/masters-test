//
//  step-2.swift
//  RubiksCube
//
//  Created by Song on 2020/12/07.
//

import Foundation

struct FlatCube {
    var originalCube: [[String]] = [["R", "R", "W"], ["G", "C", "W"], ["G", "B", "B"]]
    
    func printCube(_ cube: [[String]]) {
        for index in 0..<cube.count {
            for subIndex in 0..<cube[index].count {
                print(cube[index][subIndex], terminator: " ")
            }
            print()
        }
    }
    
    mutating func moveCube(_ moveNotation: String) {
        switch moveNotation {
        /// 가장 윗줄을 왼쪽으로 한 칸 밀기
        case "U":
            originalCube[0].append(originalCube[0].removeFirst())
            print()
            print("U")
            printCube(originalCube)
        case "Q":
            print("Bye👋")
        default:
            break
        }
    }
}
