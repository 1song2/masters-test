//
//  step-3.swift
//  RubiksCube
//
//  Created by Song on 2020/12/08.
//

import Foundation

enum Position: CaseIterable {
    case top, middle, bottom
}

enum MoveNotation: String, CaseIterable {
    case up = "U"
    case upCCW = "U'"
    case left = "L"
    case leftCCW = "L'"
    case front = "F"
    case frontCCW = "F'"
    case right = "R"
    case rightCCW = "R'"
    case back = "B"
    case backCCW = "B'"
    case down = "D"
    case downCCW = "D'"
}

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
    
    func getLayer(for position: Position) -> [String] {
        switch position {
        case .top:
            return self.topLayer
        case .middle:
            return self.middleLayer
        case .bottom:
            return self.bottomLayer
        }
    }
    
    mutating func replaceLayer(with position: Position, of rhs: Side) {
        switch position {
        case .top:
            self.topLayer = rhs.topLayer
        case .middle:
            self.middleLayer = rhs.middleLayer
        case .bottom:
            self.bottomLayer = rhs.bottomLayer
        }
    }
    
    mutating func replaceLayer(with position: Position, of rhs: [String]) {
        switch position {
        case .top:
            self.topLayer = rhs
        case .middle:
            self.middleLayer = rhs
        case .bottom:
            self.bottomLayer = rhs
        }
    }
    
    mutating func rotateFaceCW() {
        let tempSide = self
        self.topLayer = [tempSide.bottomLayer[0], tempSide.middleLayer[0], tempSide.topLayer[0]]
        self.middleLayer = [tempSide.bottomLayer[1], tempSide.middleLayer[1], tempSide.topLayer[1]]
        self.bottomLayer = [tempSide.bottomLayer[2], tempSide.middleLayer[2], tempSide.topLayer[2]]
    }
    
    mutating func rotateFaceCCW() {
        let tempSide = self
        self.topLayer = [tempSide.topLayer[2], tempSide.middleLayer[2], tempSide.bottomLayer[2]]
        self.middleLayer = [tempSide.topLayer[1], tempSide.middleLayer[1], tempSide.bottomLayer[1]]
        self.bottomLayer = [tempSide.topLayer[0], tempSide.middleLayer[0], tempSide.bottomLayer[0]]
    }
}

struct RubiksCube {
    var U, L, F, R, B, D: Side
    
    func printCube(_ cube: RubiksCube) {
        cube.U.printOneSide(leftPadding: 16)
        /// 줄간격 한칸
        print()
        for position in Position.allCases {
            for side in [cube.L, cube.F, cube.R, cube.B] {
                print(" ", terminator: "")
                side.getLayer(for: position).forEach { print($0, terminator: " ") }
                print(String(repeating: " ", count: 3), terminator: "")
            }
            print()
        }
        /// 줄간격 한칸
        print()
        cube.D.printOneSide(leftPadding: 16)
    }
    
    mutating func scrambleCube(_ cube: RubiksCube) {
        var scrambledCube = cube
        for _ in 1...30 {
            guard let safeNotation = MoveNotation.allCases.randomElement()?.rawValue else { return }
            if let safeCube = turnCube(safeNotation) {
                scrambledCube = safeCube
            }
        }
        printCube(scrambledCube)
    }
    
    mutating func turnCube(_ moveNotation: String) -> RubiksCube? {
        switch moveNotation {
        /// 가장 윗줄을 왼쪽으로 한 칸 밀기
        case MoveNotation.up.rawValue:
            U.rotateFaceCW()
            return turnLeft(position: .top)
        /// 가장 윗줄을 오른쪽으로 한 칸 밀기
        case MoveNotation.upCCW.rawValue:
            U.rotateFaceCCW()
            return turnRight(position: .top)
        /// 가장 왼쪽줄을 아래로 한 칸 밀기
        case MoveNotation.left.rawValue:
            L.rotateFaceCW()
            return pushDown(col: 0, Bcol: 2)
        /// 가장 왼쪽줄을 위로 한 칸 밀기
        case MoveNotation.leftCCW.rawValue:
            L.rotateFaceCCW()
            return pushUp(col: 0, Bcol: 2)
        /// 가장 앞쪽줄을 오른쪽으로 한 칸 밀기
        case MoveNotation.front.rawValue:
            F.rotateFaceCW()
            return pushDown(Lcol: 2, Rcol: 0, Uposition: .bottom, Dposition: .top)
        /// 가장 앞쪽줄을 왼쪽으로 한 칸 밀기
        case MoveNotation.frontCCW.rawValue:
            F.rotateFaceCCW()
            return pushUp(Lcol: 2, Rcol: 0, Uposition: .bottom, Dposition: .top)
        /// 가장 오른쪽줄을 위로 한 칸 밀기
        case MoveNotation.right.rawValue:
            R.rotateFaceCW()
            return pushUp(col: 2, Bcol: 0)
        /// 가장 오른쪽줄을 아래로 한 칸 밀기
        case MoveNotation.rightCCW.rawValue:
            R.rotateFaceCCW()
            return pushDown(col: 2, Bcol: 0)
        /// 가장 뒷쪽줄을 왼쪽으로 한 칸 밀기
        case MoveNotation.back.rawValue:
            B.rotateFaceCW()
            return pushUp(Lcol: 0, Rcol: 2, Uposition: .top, Dposition: .bottom)
        /// 가장 뒷쪽줄을 오른쪽으로 한 칸 밀기
        case MoveNotation.backCCW.rawValue:
            B.rotateFaceCCW()
            return pushDown(Lcol: 0, Rcol: 2, Uposition: .top, Dposition: .bottom)
        /// 가장 아랫줄을 오른쪽으로 한 칸 밀기
        case MoveNotation.down.rawValue:
            D.rotateFaceCW()
            return turnRight(position: .bottom)
        /// 가장 아랫줄을 왼쪽으로 한 칸 밀기
        case MoveNotation.downCCW.rawValue:
            D.rotateFaceCCW()
            return turnLeft(position: .bottom)
        default:
            return nil
        }
    }
    
    mutating func turnLeft(position: Position) -> RubiksCube {
        let tempLayer = L.getLayer(for: position)
        L.replaceLayer(with: position, of: F)
        F.replaceLayer(with: position, of: R)
        R.replaceLayer(with: position, of: B)
        B.replaceLayer(with: position, of: tempLayer)
        return RubiksCube(U: self.U, L: self.L, F: self.F, R: self.R, B: self.B, D: self.D)
    }
    
    mutating func turnRight(position: Position) -> RubiksCube {
        let tempLayer = L.getLayer(for: position)
        L.replaceLayer(with: position, of: B)
        B.replaceLayer(with: position, of: R)
        R.replaceLayer(with: position, of: F)
        F.replaceLayer(with: position, of: tempLayer)
        return RubiksCube(U: self.U, L: self.L, F: self.F, R: self.R, B: self.B, D: self.D)
    }
    
    mutating func pushDown(col: Int, Bcol: Int) -> RubiksCube {
        let tempColumn = (U.topLayer[col], U.middleLayer[col], U.bottomLayer[col])
        (U.topLayer[col], U.middleLayer[col], U.bottomLayer[col]) = (B.bottomLayer[Bcol], B.middleLayer[Bcol], B.topLayer[Bcol])
        (B.topLayer[Bcol], B.middleLayer[Bcol], B.bottomLayer[Bcol]) = (D.bottomLayer[col], D.middleLayer[col], D.topLayer[col])
        (D.topLayer[col], D.middleLayer[col], D.bottomLayer[col]) = (F.topLayer[col], F.middleLayer[col], F.bottomLayer[col])
        (F.topLayer[col], F.middleLayer[col], F.bottomLayer[col]) = tempColumn
        return RubiksCube(U: self.U, L: self.L, F: self.F, R: self.R, B: self.B, D: self.D)
    }
    
    mutating func pushUp(col: Int, Bcol: Int) -> RubiksCube {
        let tempColumn = (U.topLayer[col], U.middleLayer[col], U.bottomLayer[col])
        (U.topLayer[col], U.middleLayer[col], U.bottomLayer[col]) = (F.topLayer[col], F.middleLayer[col], F.bottomLayer[col])
        (F.topLayer[col], F.middleLayer[col], F.bottomLayer[col]) = (D.topLayer[col], D.middleLayer[col], D.bottomLayer[col])
        (D.topLayer[col], D.middleLayer[col], D.bottomLayer[col]) = (B.bottomLayer[Bcol], B.middleLayer[Bcol], B.topLayer[Bcol])
        (B.bottomLayer[Bcol], B.middleLayer[Bcol], B.topLayer[Bcol]) = tempColumn
        return RubiksCube(U: self.U, L: self.L, F: self.F, R: self.R, B: self.B, D: self.D)
    }
    
    mutating func pushDown(Lcol: Int, Rcol: Int, Uposition: Position, Dposition: Position) -> RubiksCube {
        let tempLayer = (D.getLayer(for: Dposition)[0], D.getLayer(for: Dposition)[1], D.getLayer(for: Dposition)[2])
        D.replaceLayer(with: Dposition, of: [R.bottomLayer[Rcol], R.middleLayer[Rcol], R.topLayer[Rcol]])
        (R.topLayer[Rcol], R.middleLayer[Rcol], R.bottomLayer[Rcol]) = (U.getLayer(for: Uposition)[0], U.getLayer(for: Uposition)[1], U.getLayer(for: Uposition)[2])
        U.replaceLayer(with: Uposition, of: [L.bottomLayer[Lcol], L.middleLayer[Lcol], L.topLayer[Lcol]])
        (L.topLayer[Lcol], L.middleLayer[Lcol], L.bottomLayer[Lcol]) = tempLayer
        return RubiksCube(U: self.U, L: self.L, F: self.F, R: self.R, B: self.B, D: self.D)
    }
    
    mutating func pushUp(Lcol: Int, Rcol: Int, Uposition: Position, Dposition: Position) -> RubiksCube {
        let tempLayer = (D.getLayer(for: Dposition)[2], D.getLayer(for: Dposition)[1], D.getLayer(for: Dposition)[0])
        D.replaceLayer(with: Dposition, of: [L.topLayer[Lcol], L.middleLayer[Lcol], L.bottomLayer[Lcol]])
        (L.topLayer[Lcol], L.middleLayer[Lcol], L.bottomLayer[Lcol]) = (U.getLayer(for: Uposition)[2], U.getLayer(for: Uposition)[1], U.getLayer(for: Uposition)[0])
        U.replaceLayer(with: Uposition, of: [R.topLayer[Rcol], R.middleLayer[Rcol], R.bottomLayer[Rcol]])
        (R.topLayer[Rcol], R.middleLayer[Rcol], R.bottomLayer[Rcol]) = tempLayer
        return RubiksCube(U: self.U, L: self.L, F: self.F, R: self.R, B: self.B, D: self.D)
    }
}
