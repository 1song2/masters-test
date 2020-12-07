//
//  main.swift
//  RubiksCube
//
//  Created by Song on 2020/12/07.
//

import Foundation

//let input = readLine() ?? ""
//print("\(input): \(pushChracters(input))")
/// Test cases
//print(pushChracters("apple 3 L"))   // leapp
//print(pushChracters("banana 6 R"))  // banana
//print(pushChracters("carrot -1 r")) // arrotc
//print(pushChracters("cat -4 R"))    // atc
//print(pushChracters("apple 3 R"))   // pleap
//print(pushChracters("apple -3 L"))  // pleap
//print(pushChracters("apple -3 R"))  // leapp

//TODO: - 결과값 프린트 후 exit 하지 않고 다른 input을 받을 수 있게 준비해야 함

var myCube = FlatCube()
myCube.printCube(myCube.originalCube)
print()
print("CUBE>", terminator: " ")
let input = readLine() ?? ""

input.forEach { myCube.moveCube("\($0)") }

