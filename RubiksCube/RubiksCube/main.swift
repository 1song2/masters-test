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
//var flatCube = FlatCube()
//flatCube.printCube(flatCube.cube)
//enterNotation(flatCube)

var rubiksCube = RubiksCube(
    U: Side(topLayer: ["B", "B", "B"], middleLayer: ["B", "B", "B"], bottomLayer: ["B", "B", "B"]),
    L: Side(topLayer: ["W", "W", "W"], middleLayer: ["W", "W", "W"], bottomLayer: ["W", "W", "W"]),
    F: Side(topLayer: ["O", "O", "O"], middleLayer: ["O", "O", "O"], bottomLayer: ["O", "O", "O"]),
    R: Side(topLayer: ["G", "G", "G"], middleLayer: ["G", "G", "G"], bottomLayer: ["G", "G", "G"]),
    B: Side(topLayer: ["Y", "Y", "Y"], middleLayer: ["Y", "Y", "Y"], bottomLayer: ["Y", "Y", "Y"]),
    D: Side(topLayer: ["R", "R", "R"], middleLayer: ["R", "R", "R"], bottomLayer: ["R", "R", "R"])
)

rubiksCube.printCube(rubiksCube)
enterNotation()

func enterNotation() {
    print()
    print("CUBE>", terminator: " ")
    let input = readLine() ?? ""

    if input == "Q" {
        print("Bye👋")
    } else {
        let inputArray = splitNotation(str: input)
        inputArray.forEach { item in
            print()
            print(item)
            if let safeCube = rubiksCube.turnCube(item) {
                rubiksCube.printCube(safeCube)
            }
        }
        enterNotation()
    }
}

func splitNotation(str: String) -> [String] {
    var inputArray = [String]()
    var input = str
    while input.count != 0 {
        let firstChar = input.removeFirst()
        input.first == "'" ? inputArray.append("\(firstChar)\(input.removeFirst())") : inputArray.append("\(firstChar)")
    }
    return inputArray
}
