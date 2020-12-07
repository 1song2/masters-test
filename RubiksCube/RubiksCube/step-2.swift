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
    
    mutating func turnCube(_ moveNotation: String) -> [[String]]? {
        switch moveNotation {
        case "Q":
            print("Bye👋")
            return nil
        /// 가장 윗줄을 왼쪽으로 한 칸 밀기
        case "U":
            turnLeft(row: 0)
            return movedCube
        /// 가장 윗줄을 오른쪽으로 한 칸 밀기
        case "U'":
            turnRight(row: 0)
            return movedCube
        /// 가장 오른쪽 줄을 위로 한 칸 밀기
        case "R":
            pushUp(column: movedCube.count - 1)
            return movedCube
        /// 가장 오른쪽 줄을 아래로 한 칸 밀기
        case "R'":
            pushDown(column: movedCube.count - 1)
            return movedCube
        /// 가장 왼쪽 줄을 아래로 한 칸 밀기
        case "L":
            pushDown(column: 0)
            return movedCube
        /// 가장 왼쪽 줄을 위로 한 칸 밀기
        case "L'":
            pushUp(column: 0)
            return movedCube
        /// 가장 아랫줄을 오른쪽으로 한 칸 밀기
        case "B":
            turnRight(row: 2)
            return movedCube
        /// 가장 아랫줄을 왼쪽으로 한 칸 밀기
        case "B'":
            turnLeft(row: 2)
            return movedCube
        default:
            return nil
        }
    }
    
    mutating func turnLeft(row: Int) {
        movedCube[row].append(movedCube[row].removeFirst())
    }
    
    mutating func turnRight(row: Int) {
        movedCube[row].insert(movedCube[row].removeLast(), at: 0)
    }
    
    mutating func pushUp(column: Int) {
        for index in 0..<movedCube.count {
            if index - 1 < 0 {
                movedCube[movedCube.count - 1][column] = movedCube[index][column]
            } else if index == 2 {
                movedCube[movedCube.count - 2][column] = originalCube[originalCube.count - 1][column]
            } else {
                movedCube[index - 1][column] = movedCube[index][column]
            }
        }
    }
    
    mutating func pushDown(column: Int) {
        for index in stride(from: movedCube.count - 1, through: 0, by: -1) {
            if index + 1 > 2 {
                movedCube[0][column] = movedCube[index][column]
            } else if index == 0 {
                movedCube[movedCube.count - 2][column] = originalCube[0][column]
            } else {
                movedCube[index + 1][column] = movedCube[index][column]
            }
        }
    }
}
