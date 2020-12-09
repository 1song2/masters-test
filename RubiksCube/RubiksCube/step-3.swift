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
        for layer in [self.topLayer, self.middleLayer, self.bottomLayer] {
            print(String(repeating: " ", count: leftPadding), terminator: "")
            layer.forEach { print($0, terminator: " ") }
            print()
        }
    }
}

struct RubiksCube {
    let U, L, F, R, B, D: Side
    
    func printCube() {
        U.printOneSide(leftPadding: 16)
        /// 다음 면으로 줄바꿈
        print()
        for side in [self.L, self.F, self.R, self.B] {
            print(" ", terminator: "")
            side.topLayer.forEach { print($0, terminator: " ") }
            print(String(repeating: " ", count: 3), terminator: "")
        }
        print()
        for side in [self.L, self.F, self.R, self.B] {
            print(" ", terminator: "")
            side.middleLayer.forEach { print($0, terminator: " ") }
            print(String(repeating: " ", count: 3), terminator: "")
        }
        print()
        for side in [self.L, self.F, self.R, self.B] {
            print(" ", terminator: "")
            side.bottomLayer.forEach { print($0, terminator: " ") }
            print(String(repeating: " ", count: 3), terminator: "")
        }
        /// 다음 면으로 줄바꿈
        print()
        print()
        D.printOneSide(leftPadding: 16)
    }
}
