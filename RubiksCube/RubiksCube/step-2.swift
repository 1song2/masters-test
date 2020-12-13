//
//  step-2.swift
//  RubiksCube
//
//  Created by Song on 2020/12/07.
//

import Foundation

struct FlatCube {
    var cube: [[String]]
    
    func printCube(_ cube: [[String]]) {
        for index in 0..<cube.count {
            for subIndex in 0..<cube[index].count {
                print(cube[index][subIndex], terminator: " ")
            }
            print()
        }
    }
    
    mutating func turnCube(_ moveNotation: String) -> [[String]] {
        switch moveNotation {
        /// 가장 윗줄을 왼쪽으로 한 칸 밀기
        case "U":
            turnLeft(row: 0)
            return cube
        /// 가장 윗줄을 오른쪽으로 한 칸 밀기
        case "U'":
            turnRight(row: 0)
            return cube
        /// 가장 오른쪽 줄을 위로 한 칸 밀기
        case "R":
            pushUp(column: cube.count - 1)
            return cube
        /// 가장 오른쪽 줄을 아래로 한 칸 밀기
        case "R'":
            pushDown(column: cube.count - 1)
            return cube
        /// 가장 왼쪽 줄을 아래로 한 칸 밀기
        case "L":
            pushDown(column: 0)
            return cube
        /// 가장 왼쪽 줄을 위로 한 칸 밀기
        case "L'":
            pushUp(column: 0)
            return cube
        /// 가장 아랫줄을 오른쪽으로 한 칸 밀기
        case "B":
            turnRight(row: 2)
            return cube
        /// 가장 아랫줄을 왼쪽으로 한 칸 밀기
        case "B'":
            turnLeft(row: 2)
            return cube
        default:
            return [[String]]()
        }
    }
    
    mutating func turnLeft(row: Int) {
        cube[row].append(cube[row].removeFirst())
    }
    
    mutating func turnRight(row: Int) {
        cube[row].insert(cube[row].removeLast(), at: 0)
    }
    
    mutating func pushUp(column: Int) {
        let storedValue = cube[cube.count - 1][column]
        for index in 0..<cube.count {
            if index - 1 < 0 {
                cube[cube.count - 1][column] = cube[index][column]
            } else if index == 2 {
                cube[cube.count - 2][column] = storedValue
            } else {
                cube[index - 1][column] = cube[index][column]
            }
        }
    }
    
    mutating func pushDown(column: Int) {
        let storedValue = cube[0][column]
        for index in stride(from: cube.count - 1, through: 0, by: -1) {
            if index + 1 > 2 {
                cube[0][column] = cube[index][column]
            } else if index == 0 {
                cube[cube.count - 2][column] = storedValue
            } else {
                cube[index + 1][column] = cube[index][column]
            }
        }
    }
}
