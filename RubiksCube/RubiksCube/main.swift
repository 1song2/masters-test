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

//TODO: - 객체를 적절히 활용할 것
//FIXME: - UUR 입력해 결과 출력 후 다시 UUR 입력시 틀린 결과값이 출력됨
    //틀린 결과값
    //W W B
    //G C B
    //G B R
    //예상 결과값
    //W W B
    //G C R
    //G B R
var myCube = FlatCube()
myCube.printCube(myCube.originalCube)
enterMoveNotation()

func enterMoveNotation() {
    print()
    print("CUBE>", terminator: " ")
    var input = readLine() ?? ""
    
    if input == "Q" {
        print("Bye👋")
    } else {
        var inputArray = [String]()
        while input.count != 0 {
            let firstCharacter = input.removeFirst()
            if input.first == "'" {
                inputArray.append("\(firstCharacter)\(input.removeFirst())")
            } else {
                inputArray.append("\(firstCharacter)")
            }
        }

        inputArray.forEach { input in
            if let safeCube = myCube.turnCube(input) {
                print()
                print(input)
                myCube.printCube(safeCube)
            }
        }
        enterMoveNotation()
    }
}
