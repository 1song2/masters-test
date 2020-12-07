//
//  main.swift
//  RubiksCube
//
//  Created by Song on 2020/12/07.
//

import Foundation

let input = readLine() ?? ""

func pushChracters(_ input: String) {
    let inputArray = input.components(separatedBy: " ")
    var word = inputArray[0]
    guard let number = Int(inputArray[1]) else { return }
    let direction = inputArray[2]
    
    //apple 3 L부터 구현해보기
    for _ in 0..<number {
        word += "\(word.removeFirst())"
    }
    print(word)
}

pushChracters(input)
