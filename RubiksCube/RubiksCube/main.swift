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
var flatCube = RubiksCube(cube: [
    Side(topLayer: ["R", "R", "W"], middleLayer: ["G", "C", "W"], bottomLayer: ["G", "B", "B"])
])
//flatCube.printCube(flatCube.cube)
//enterNotation(flatCube)

var rubiksCube = RubiksCube(cube: [
    Side(topLayer: ["B", "B", "B"], middleLayer: ["B", "B", "B"], bottomLayer: ["B", "B", "B"]), // U
    Side(topLayer: ["W", "W", "W"], middleLayer: ["W", "W", "W"], bottomLayer: ["W", "W", "W"]), // L
    Side(topLayer: ["O", "O", "O"], middleLayer: ["O", "O", "O"], bottomLayer: ["O", "O", "O"]), // F
    Side(topLayer: ["G", "G", "G"], middleLayer: ["G", "G", "G"], bottomLayer: ["G", "G", "G"]), // R
    Side(topLayer: ["Y", "Y", "Y"], middleLayer: ["Y", "Y", "Y"], bottomLayer: ["Y", "Y", "Y"]), // B
    Side(topLayer: ["R", "R", "R"], middleLayer: ["R", "R", "R"], bottomLayer: ["R", "R", "R"])  // D
])
rubiksCube.printCube(rubiksCube.cube)

//rubiksCube.printCube(rubiksCube.cube)
//enterNotation(rubiksCube)

//func enterNotation(_ cube: RubiksCube) {
//    var newCube = cube
//    print()
//    print("CUBE>", terminator: " ")
//    let input = readLine() ?? ""
//
//    if input == "Q" {
//        print("Bye👋")
//    } else {
//        let inputArray = splitNotation(str: input)
//        inputArray.forEach { item in
//            print()
//            print(item)
//            let turnedCube = newCube.turnCube(item)
//            newCube.printCube(turnedCube)
//        }
//        enterNotation(newCube)
//    }
//}

func splitNotation(str: String) -> [String] {
    var inputArray = [String]()
    var input = str
    while input.count != 0 {
        let firstChar = input.removeFirst()
        input.first == "'" ? inputArray.append("\(firstChar)\(input.removeFirst())") : inputArray.append("\(firstChar)")
    }
    return inputArray
}
