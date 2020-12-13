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

//var flatCube = FlatCube(cube: [["R", "R", "W"], ["G", "C", "W"], ["G", "B", "B"]])
//flatCube.printCube(flatCube.cube)
//enterNotation()

var moves = 0
var rubiksCube = RubiksCube(
    U: Side(topLayer: ["B", "B", "B"], middleLayer: ["B", "B", "B"], bottomLayer: ["B", "B", "B"]),
    L: Side(topLayer: ["W", "W", "W"], middleLayer: ["W", "W", "W"], bottomLayer: ["W", "W", "W"]),
    F: Side(topLayer: ["O", "O", "O"], middleLayer: ["O", "O", "O"], bottomLayer: ["O", "O", "O"]),
    R: Side(topLayer: ["G", "G", "G"], middleLayer: ["G", "G", "G"], bottomLayer: ["G", "G", "G"]),
    B: Side(topLayer: ["Y", "Y", "Y"], middleLayer: ["Y", "Y", "Y"], bottomLayer: ["Y", "Y", "Y"]),
    D: Side(topLayer: ["R", "R", "R"], middleLayer: ["R", "R", "R"], bottomLayer: ["R", "R", "R"])
)
let start = Date()

print(
    """
    🎪 루빅스 큐브 게임에 오신 것을 환영합니다
    
    1️⃣ 회전 기호를 입력해 큐브를 움직입니다
    2️⃣ 큐브를 무작위로 섞으시려면 S를 입력해주세요
    3️⃣ 게임을 종료하시려면 Q를 입력해주세요
    
    """
)
rubiksCube.printCube(rubiksCube)
enterNotation()

func enterNotation() {
    print("CUBE>", terminator: " ")
    let input = readLine() ?? ""

    if input == "Q" {
        print("⌛️ 경과 시간: \(getElapsedTime())")
        print("💬 총 \(moves)번 움직이셨네요!")
        print("그럼 다음에 또 만나요 👋")
    } else if input == "S" {
        rubiksCube.printCube(rubiksCube.scrambleCube())
        enterNotation()
    } else {
        let inputArray = splitNotation(str: input)
        inputArray.forEach { item in
            print()
            print(item)
            guard let safeCube = rubiksCube.turnCube(item) else { return }
            rubiksCube.printCube(safeCube)
            moves += 1
        }
        if checkSolved() {
            print("⌛️ 경과 시간: \(getElapsedTime())")
            print("축하합니다! \(moves)번만에 큐브를 맞추셨어요 🥳")
        } else {
            enterNotation()
        }
    }
}

func checkSolved() -> Bool {
    return rubiksCube.U.checkSideSolved() && rubiksCube.L.checkSideSolved() && rubiksCube.F.checkSideSolved() && rubiksCube.R.checkSideSolved() && rubiksCube.B.checkSideSolved() && rubiksCube.D.checkSideSolved()
}

func splitNotation(str: String) -> [String] {
    var inputArray = [String]()
    var input = str
    while input.count != 0 {
        let firstChar = input.removeFirst()
        if input.first == "'" {
            inputArray.append("\(firstChar)\(input.removeFirst())")
        } else if input.first == "2" {
            inputArray.append("\(firstChar)")
            inputArray.append("\(firstChar)")
            input.removeFirst(1)
        } else {
            inputArray.append("\(firstChar)")
        }
    }
    return inputArray
}

func getElapsedTime() -> String {
    let timeInterval = start.timeIntervalSinceNow
    let hours = Int(timeInterval) * -1 / 3600
    let minutes = Int(timeInterval) * -1 / 60 % 60
    let seconds = Int(timeInterval) * -1 % 60
    var times = [String]()
    if hours > 0 {
        times.append("\(hours)시")
    }
    if minutes > 0 {
        times.append("\(minutes)분")
    }
    times.append("\(seconds)초")
    return times.joined(separator: " ")
}
