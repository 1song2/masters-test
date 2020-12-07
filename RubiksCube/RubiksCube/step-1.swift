//
//  step-1.swift
//  RubiksCube
//
//  Created by Song on 2020/12/07.
//

import Foundation

func pushChracters(_ input: String) -> String {
    let inputArray = input.components(separatedBy: " ")
    var word = inputArray[0]
    guard let number = Int(inputArray[1]) else {
        fatalError("Can't convert String to Int")
    }
    let direction = inputArray[2]
    
    let condition = (number > 0, direction)
    switch condition {
    case (true, "L"), (true, "l"):
        for _ in 0..<number {
            word += "\(word.removeFirst())"
        }
    case (true, "R"), (true, "r"):
        for _ in 0..<number {
            word = "\(word.removeLast())" + word
        }
    case (false, "R"), (false, "r"):
        for _ in 0..<(number * -1) {
            word += "\(word.removeFirst())"
        }
    case (false, "L"), (false, "l"):
        for _ in 0..<(number * -1) {
            word = "\(word.removeLast())" + word
        }
    default:
        break
    }
    return word
}
