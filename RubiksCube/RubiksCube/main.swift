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
var myCube = FlatCube()
myCube.printCube(myCube.cube)
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
            let firstChar = input.removeFirst()
            input.first == "'" ? inputArray.append("\(firstChar)\(input.removeFirst())") : inputArray.append("\(firstChar)")
        }

        inputArray.forEach { input in
            print()
            print(input)
            myCube.printCube(myCube.turnCube(input))
        }
        enterMoveNotation()
    }
}
