//
//  main.swift
//  RubiksCube
//
//  Created by Song on 2020/12/07.
//

import Foundation

let input = readLine() ?? ""

func pushChracters(_ input: String) {
    let word = input.components(separatedBy: " ")[0]
    let number = input.components(separatedBy: " ")[1]
    let direction = input.components(separatedBy: " ")[2]
    print("word: \(word), number: \(number), direction: \(direction)")
}

pushChracters(input)
