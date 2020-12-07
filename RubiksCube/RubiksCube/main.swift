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

//TODO: - 결과값 프린트 후 exit 하지 않고 다른 input을 받을 수 있게 readLine() 준비해야 함
//TODO: - 한번에 여러 문자 입력하는 경우 어떻게 처리할 지 생각 (UUR 같은 경우 forEach로 처리 가능하지만 작은따옴표가 포함된다면?)
//TODO: - 함수 길이 정리 (쪼개서 공통으로 사용할 수 있는 경우?)
//TODO: - 객체를 적절히 활용할 것

var myCube = FlatCube()
myCube.printCube(myCube.originalCube)
print()
print("CUBE>", terminator: " ")
let input = readLine() ?? ""

//input.forEach { myCube.moveCube("\($0)") }
myCube.turnCube(input)

