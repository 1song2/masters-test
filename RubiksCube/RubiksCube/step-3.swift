//
//  step-3.swift
//  RubiksCube
//
//  Created by Song on 2020/12/08.
//

import Foundation

struct Side {
    var topLayer: [String]
    var middleLayer: [String]
    var bottomLayer: [String]
    
    func printOneSide(leftPadding: Int) {
        for layer in [self.topLayer, self.middleLayer, self.bottomLayer] {
            print(String(repeating: " ", count: leftPadding), terminator: "")
            layer.forEach { print($0, terminator: " ") }
            print()
        }
    }
}

struct RubiksCube {
    var U, L, F, R, B, D: Side
    
    func printCube(_ cube: RubiksCube) {
        cube.U.printOneSide(leftPadding: 16)
        /// 다음 면으로 줄바꿈
        print()
        for side in [cube.L, cube.F, cube.R, cube.B] {
            print(" ", terminator: "")
            side.topLayer.forEach { print($0, terminator: " ") }
            print(String(repeating: " ", count: 3), terminator: "")
        }
        print()
        for side in [cube.L, cube.F, cube.R, cube.B] {
            print(" ", terminator: "")
            side.middleLayer.forEach { print($0, terminator: " ") }
            print(String(repeating: " ", count: 3), terminator: "")
        }
        print()
        for side in [cube.L, cube.F, cube.R, cube.B] {
            print(" ", terminator: "")
            side.bottomLayer.forEach { print($0, terminator: " ") }
            print(String(repeating: " ", count: 3), terminator: "")
        }
        /// 다음 면으로 줄바꿈
        print()
        print()
        cube.D.printOneSide(leftPadding: 16)
    }
    
    mutating func turnCube(_ moveNotation: String) -> RubiksCube? {
        switch moveNotation {
        /// 가장 윗줄을 왼쪽으로 한 칸 밀기
        case "U":
            //turnLeft()
            let LTopLayer = L.topLayer
            L.topLayer = F.topLayer
            F.topLayer = R.topLayer
            R.topLayer = B.topLayer
            B.topLayer = LTopLayer
            return RubiksCube(U: self.U, L: self.L, F: self.F, R: self.R, B: self.B, D: self.D)
        /// 가장 윗줄을 오른쪽으로 한 칸 밀기
        case "U'":
            //turnRight()
            let LTopLayer = L.topLayer
            L.topLayer = B.topLayer
            B.topLayer = R.topLayer
            R.topLayer = F.topLayer
            F.topLayer = LTopLayer
            return RubiksCube(U: self.U, L: self.L, F: self.F, R: self.R, B: self.B, D: self.D)
        case "L":
            let UleftColumn = (U.topLayer[0], U.middleLayer[0], U.bottomLayer[0])
            (U.topLayer[0], U.middleLayer[0], U.bottomLayer[0]) = (B.bottomLayer[2], B.middleLayer[2], B.topLayer[2])
            (B.topLayer[2], B.middleLayer[2], B.bottomLayer[2]) = (D.bottomLayer[0], D.middleLayer[0], D.topLayer[0])
            (D.topLayer[0], D.middleLayer[0], D.bottomLayer[0]) = (F.topLayer[0], F.middleLayer[0], F.bottomLayer[0])
            (F.topLayer[0], F.middleLayer[0], F.bottomLayer[0]) = UleftColumn
            return RubiksCube(U: self.U, L: self.L, F: self.F, R: self.R, B: self.B, D: self.D)
        case "L'":
            let ULeftColumn = (U.topLayer[0], U.middleLayer[0], U.bottomLayer[0])
            (U.topLayer[0], U.middleLayer[0], U.bottomLayer[0]) = (F.topLayer[0], F.middleLayer[0], F.bottomLayer[0])
            (F.topLayer[0], F.middleLayer[0], F.bottomLayer[0]) = (D.topLayer[0], D.middleLayer[0], D.bottomLayer[0])
            (D.topLayer[0], D.middleLayer[0], D.bottomLayer[0]) = (B.bottomLayer[2], B.middleLayer[2], B.topLayer[2])
            (B.bottomLayer[2], B.middleLayer[2], B.topLayer[2]) = ULeftColumn
            return RubiksCube(U: self.U, L: self.L, F: self.F, R: self.R, B: self.B, D: self.D)
        case "F":
            let DTopLayer = (D.topLayer[0], D.topLayer[1], D.topLayer[2])
            D.topLayer = [R.bottomLayer[0], R.middleLayer[0], R.topLayer[0]]
            (R.topLayer[0], R.middleLayer[0], R.bottomLayer[0]) = (U.bottomLayer[0], U.bottomLayer[1], U.bottomLayer[1])
            U.bottomLayer = [L.bottomLayer[2], L.middleLayer[2], L.topLayer[2]]
            (L.topLayer[2], L.middleLayer[2], L.bottomLayer[2]) = DTopLayer
            return RubiksCube(U: self.U, L: self.L, F: self.F, R: self.R, B: self.B, D: self.D)
        case "F'":
            let DTopLayer = (D.topLayer[2], D.topLayer[1], D.topLayer[0])
            D.topLayer = [L.topLayer[2], L.middleLayer[2], L.bottomLayer[2]]
            (L.topLayer[2], L.middleLayer[2], L.bottomLayer[2]) = (U.bottomLayer[2], U.bottomLayer[1], U.bottomLayer[0])
            U.bottomLayer = [R.topLayer[0], R.middleLayer[0], R.bottomLayer[0]]
            (R.topLayer[0], R.middleLayer[0], R.bottomLayer[0]) = DTopLayer
            return RubiksCube(U: self.U, L: self.L, F: self.F, R: self.R, B: self.B, D: self.D)
        case "R":
            let URightColumn = (U.topLayer[2], U.middleLayer[2], U.bottomLayer[2])
            (U.topLayer[2], U.middleLayer[2], U.bottomLayer[2]) = (F.topLayer[2], F.middleLayer[2], F.bottomLayer[2])
            (F.topLayer[2], F.middleLayer[2], F.bottomLayer[2]) = (D.topLayer[2], D.middleLayer[2], D.bottomLayer[2])
            (D.topLayer[2], D.middleLayer[2], D.bottomLayer[2]) = (B.bottomLayer[0], B.middleLayer[0], B.topLayer[0])
            (B.bottomLayer[0], B.middleLayer[0], B.topLayer[0]) = URightColumn
            return RubiksCube(U: self.U, L: self.L, F: self.F, R: self.R, B: self.B, D: self.D)
        case "R'":
            let URightColumn = (U.topLayer[2], U.middleLayer[2], U.bottomLayer[2])
            (U.topLayer[2], U.middleLayer[2], U.bottomLayer[2]) = (B.bottomLayer[0], B.middleLayer[0], B.topLayer[0])
            (B.topLayer[0], B.middleLayer[0], B.bottomLayer[0]) = (D.bottomLayer[2], D.middleLayer[2], D.topLayer[2])
            (D.topLayer[2], D.middleLayer[2], D.bottomLayer[2]) = (F.topLayer[2], F.middleLayer[2], F.bottomLayer[2])
            (F.topLayer[2], F.middleLayer[2], F.bottomLayer[2]) = URightColumn
            return RubiksCube(U: self.U, L: self.L, F: self.F, R: self.R, B: self.B, D: self.D)
        case "B":
            let DBottomLayer = (D.bottomLayer[2], D.bottomLayer[1], D.bottomLayer[0])
            D.bottomLayer = [L.topLayer[0], L.middleLayer[0], L.bottomLayer[0]]
            (L.topLayer[0], L.middleLayer[0], L.bottomLayer[0]) = (U.topLayer[2], U.topLayer[1], U.topLayer[0])
            U.topLayer = [R.topLayer[2], R.middleLayer[2], R.bottomLayer[2]]
            (R.topLayer[2], R.middleLayer[2], R.bottomLayer[2]) = DBottomLayer
            return RubiksCube(U: self.U, L: self.L, F: self.F, R: self.R, B: self.B, D: self.D)
        case "B'":
            let DBottomLayer = (D.bottomLayer[0], D.bottomLayer[1], D.bottomLayer[2])
            D.bottomLayer = [R.bottomLayer[2], R.middleLayer[2], R.topLayer[2]]
            (R.topLayer[2], R.middleLayer[2], R.bottomLayer[2]) = (U.topLayer[0], U.topLayer[1], U.topLayer[1])
            U.topLayer = [L.bottomLayer[0], L.middleLayer[0], L.topLayer[0]]
            (L.topLayer[0], L.middleLayer[0], L.bottomLayer[0]) = DBottomLayer
            return RubiksCube(U: self.U, L: self.L, F: self.F, R: self.R, B: self.B, D: self.D)
        /// 가장 아랫줄을 오른쪽으로 한 칸 밀기
        case "D":
            //turnRight()
            let LBottomLayer = L.bottomLayer
            L.bottomLayer = B.bottomLayer
            B.bottomLayer = R.bottomLayer
            R.bottomLayer = F.bottomLayer
            F.bottomLayer = LBottomLayer
            return RubiksCube(U: self.U, L: self.L, F: self.F, R: self.R, B: self.B, D: self.D)
        /// 가장 아랫줄을 왼쪽으로 한 칸 밀기
        case "D'":
            //turnLeft()
            let LBottomLayer = L.bottomLayer
            L.bottomLayer = F.bottomLayer
            F.bottomLayer = R.bottomLayer
            R.bottomLayer = B.bottomLayer
            B.bottomLayer = LBottomLayer
            return RubiksCube(U: self.U, L: self.L, F: self.F, R: self.R, B: self.B, D: self.D)
        default:
            return nil
        }
    }
}
