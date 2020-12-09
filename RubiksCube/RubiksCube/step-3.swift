//
//  step-3.swift
//  RubiksCube
//
//  Created by Song on 2020/12/08.
//

import Foundation

struct Side {
    let topLayer: [String]
    let middleLayer: [String]
    let bottomLayer: [String]
    
    func printOneSide(leftPadding: Int) {
        print(String(repeating: " ", count: leftPadding), terminator: "")
        topLayer.forEach { print($0, terminator: " ") }
        print()
        print(String(repeating: " ", count: leftPadding), terminator: "")
        middleLayer.forEach { print($0, terminator: " ") }
        print()
        print(String(repeating: " ", count: leftPadding), terminator: "")
        bottomLayer.forEach { print($0, terminator: " ") }
        print()
    }
}

struct RubiksCube {
    var cube: [Side]
    
    func printCube(_ cube: [Side]) {
        /// step-2 (평면 큐브)
        if cube.count == 1 {
            cube[0].printOneSide(leftPadding: 0)
        /// step-3 (6면 큐브)
        } else {
            cube[0].printOneSide(leftPadding: 16)
            /// 다음 면으로 줄바꿈
            print()
            for index in 1...4 {
                print(" ", terminator: "")
                cube[index].topLayer.forEach { print($0, terminator: " ") }
                print(String(repeating: " ", count: 3), terminator: "")
            }
            print()
            for index in 1...4 {
                print(" ", terminator: "")
                cube[index].middleLayer.forEach { print($0, terminator: " ") }
                print(String(repeating: " ", count: 3), terminator: "")
            }
            print()
            for index in 1...4 {
                print(" ", terminator: "")
                cube[index].bottomLayer.forEach { print($0, terminator: " ") }
                print(String(repeating: " ", count: 3), terminator: "")
            }
            /// 다음 면으로 줄바꿈
            print()
            print()
            cube[5].printOneSide(leftPadding: 16)
        }
    }
}
