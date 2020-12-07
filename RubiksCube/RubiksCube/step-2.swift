//
//  step-2.swift
//  RubiksCube
//
//  Created by Song on 2020/12/07.
//

import Foundation

struct FlatCube {
    let originalCube: [[String]] = [["R", "R", "W"], ["G", "C", "W"], ["G", "B", "B"]]
    lazy var movedCube = originalCube
    
    func printCube(_ cube: [[String]]) {
        for index in 0..<cube.count {
            for subIndex in 0..<cube[index].count {
                print(cube[index][subIndex], terminator: " ")
            }
            print()
        }
    }
    
    mutating func turnCube(_ moveNotation: String) {
        switch moveNotation {
        /// 가장 윗줄을 왼쪽으로 한 칸 밀기
        case "U":
            movedCube[0].append(movedCube[0].removeFirst())
            print()
            print("U")
            printCube(movedCube)
        /// 가장 윗줄을 오른쪽으로 한 칸 밀기
        case "U'":
            movedCube[0].insert(movedCube[0].removeLast(), at: 0)
            print()
            print("U'")
            printCube(movedCube)
        /// 가장 오른쪽 줄을 위로 한 칸 밀기
        case "R":
            for index in 0..<movedCube.count {
                if index - 1 < 0 {
                    movedCube[movedCube.count - 1][movedCube.count - 1] = movedCube[index][movedCube.count - 1]
                } else if index == 2 {
                    movedCube[movedCube.count - 2][movedCube.count - 1] = originalCube[originalCube.count - 1][originalCube.count - 1]
                } else {
                    movedCube[index - 1][movedCube.count - 1] = movedCube[index][movedCube.count - 1]
                }
            }
            print()
            print("R")
            printCube(movedCube)
        /// 가장 오른쪽 줄을 아래로 한 칸 밀기
        case "R'":
            //for index in 0..<movedCube.count {
            for index in stride(from: movedCube.count - 1, through: 0, by: -1) {
                if index + 1 > 2 {
                    movedCube[0][movedCube.count - 1] = movedCube[index][movedCube.count - 1]
                } else if index == 0 {
                    movedCube[movedCube.count - 2][movedCube.count - 1] = originalCube[0][originalCube.count - 1]
                } else {
                    movedCube[index + 1][movedCube.count - 1] = movedCube[index][movedCube.count - 1]
                }
            }
            print()
            print("R'")
            printCube(movedCube)
        /// 가장 왼쪽 줄을 아래로 한 칸 밀기
        case "L":
            for index in stride(from: movedCube.count - 1, through: 0, by: -1) {
                if index + 1 > 2 {
                    movedCube[0][0] = movedCube[index][0]
                } else if index == 0 {
                    movedCube[movedCube.count - 2][0] = originalCube[0][0]
                } else {
                    movedCube[index + 1][0] = movedCube[index][0]
                }
            }
            print()
            print("L")
            printCube(movedCube)
        /// 가장 왼쪽 줄을 위로 한 칸 밀기
        case "L'":
            for index in 0..<movedCube.count {
                if index - 1 < 0 {
                    movedCube[movedCube.count - 1][0] = movedCube[index][0]
                } else if index == 2 {
                    movedCube[movedCube.count - 2][0] = originalCube[originalCube.count - 1][0]
                } else {
                    movedCube[index - 1][0] = movedCube[index][0]
                }
            }
            print()
            print("L'")
            printCube(movedCube)
        /// 가장 아랫줄을 오른쪽으로 한 칸 밀기
        case "B":
            movedCube[2].insert(movedCube[2].removeLast(), at: 0)
            print()
            print("B")
            printCube(movedCube)
        /// 가장 아랫줄을 왼쪽으로 한 칸 밀기
        case "B'":
            movedCube[2].append(movedCube[2].removeFirst())
            print()
            print("B'")
            printCube(movedCube)
        case "Q":
            print("Bye👋")
        default:
            break
        }
    }
}
