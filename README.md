# masters-test
2021 마스터즈 코스 1차 테스트 문제 (루빅스 큐브 구현하기)

## 1단계: 단어 밀어내기

1. readLine() 함수를 통해 "단어 숫자 방향" 값을 입력 받는다. e.g. "apple 3 L"
```Swift
let input = readLine() ?? ""
```
2. 입력값을 components() 함수를 이용해 공백(" ")을 기준으로 나누고 각각 변수/상수로 선언한다. 이때 숫자는 Int로 타입을 변환한다.
```Swift
let inputArray = input.components(separatedBy: " ")
var word = inputArray[0]
guard let number = Int(inputArray[1]) else {
    fatalError("Can't convert String to Int")
}
let direction = inputArray[2]
```
3. 조건에 따라 출력되는 값이 다르므로 그 분기 역할을 할 condition을 Tuple 형식으로 선언한다. 첫번째 조건은 양의 정수이면 true, 음의 정수이면 false인 Bool 값, 두번째 조건은 위에서 선언한 direction이다.
```Swift
let condition = (number > 0, direction)
```
4. switch case문을 통해 주어진 word값을 가공한다.
```Swift
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
```
* 주어진 양의 정수만큼의 글자를 왼쪽으로 밀어 반대편에 채운다.
* 주어진 양의 정수만큼의 글자를 오른쪽으로 밀어 반대편에 채운다.
* 주어진 음의 정수만큼의 글자를 왼쪽으로 밀어 반대편에 채운다.
* 주어진 음의 정수만큼의 글자를 오른쪽으로 밀어 반대편에 채운다.
    
왼쪽으로 밀리는 글자는 항상 단어의 첫번째 글자, 오른쪽으로 밀리는 글자는 항상 단어의 마지막 글자가 되므로 각각 removeFirst()와 removeLast() 함수를 이용해 구현했다.

## 2단계: 평면 큐브

1. FlatCube 구조체 내에 2차원 배열 cube를 프로퍼티로 선언한다.
```Swift
var cube: [[String]]
```
2. 2차원 배열인 cube를 출력할 수 있는 printCube() 메소드를 선언한다.
```Swift
func printCube(_ cube: [[String]]) {
    for index in 0..<cube.count {
        for subIndex in 0..<cube[index].count {
            print(cube[index][subIndex], terminator: " ")
        }
        print()
    }
}
```
3. 사용자 입력값에 따라 큐브의 특정 한줄을 특정 방향으로 한칸 미는 동작을 하는 turnCube() 메소드를 선언한다. 움직이는 방향(좌우상하)에 따라 하위 모듈 메소드를 만들어 호출해 사용할 수 있도록 했다. cube 프로퍼티를 수정해야 하므로 메소드 앞에 mutating 키워드를 붙인다.
4. 사용자 입력값에 turnCube() 메소드를 적용할 수 있도록 가공하는 enterMoveNotation() 함수를 선언한다.
5. 키보드 입력을 받기 전 'CUBE>'를 콘솔에 표시하기 위해 print() 함수를 사용한다. 이때 terminator 인자를 사용해 줄바꿈이 되지 않도록 한다.
```Swift
print("CUBE>", terminator: " ")
var input = readLine() ?? ""
```
6. if문을 사용해 사용자 입력값이 "Q"이면 "Bye👋"를 출력하고 프로그램이 더 이상 이어지지 않게 한다. (= 프로그램을 종료한다.)
7. 입력값이 "Q"가 아니라면 String을 Array로 가공해 여러 문자도 순서대로 처리해줄 수 있게 한다. 이때 문자에 프라임 기호(')가 포함된 경우를 고려해야 하므로 while문을 이용해 적절한 위치에서 String을 끊어갈 수 있도록 조치했다.
```Swift
var inputArray = [String]()
while input.count != 0 {
    let firstChar = input.removeFirst()
    input.first == "'" ? inputArray.append("\(firstChar)\(input.removeFirst())") : inputArray.append("\(firstChar)")
}
```
8. 정의된 최소 단위의 문자열로 쪼개진 inputArray 배열의 내부 아이템을 매개변수로 turnCube() 메소드를 호출하기 위해 forEach 클로저를 사용한다.
```Swift
inputArray.forEach { input in
    print()
    print(input)
    flatCube.printCube(flatCube.turnCube(input))
}
```
9. "Q"가 입력되기 전까지 계속 프로그램을 이어갈 수 있도록 enterMoveNotation() 함수를 재귀호출한다.
10. FlatCube 타입의 flatCube 인스턴스 생성한다. 초기 큐브 상태를 출력하기 위해 printCube() 메소드를 호출한 후, 위에서 선언한 enterMoveNotation() 함수를 호출한다.
```Swift
var flatCube = FlatCube(cube: [["R", "R", "W"], ["G", "C", "W"], ["G", "B", "B"]])
flatCube.printCube(flatCube.cube)
enterMoveNotation()
```
## 3단계: 루빅스 큐브

1. 큐브의 한쪽 면에 해당하는 Side 구조체 내에 String의 배열 topLayer, middleLayer, bottomLayer를 프로퍼티로 선언한다.
```Swift
var topLayer: [String]
var middleLayer: [String]
var bottomLayer: [String]
```
2. 6면체 평면 큐브를 출력하기 위한 모듈로써 printOneSide() 메소드를 선언한다. 큐브의 윗면 및 아랫면과 나머지 다른 면들의 왼쪽 빈 공간의 크기가 다르므로 leftPadding을 매개변수로 받아 그 숫자만큼 패딩을 줄 수 있도록 처리했다.
```Swift
func printOneSide(leftPadding: Int) {
    for layer in [self.topLayer, self.middleLayer, self.bottomLayer] {
        print(String(repeating: " ", count: leftPadding), terminator: "")
        layer.forEach { print($0, terminator: " ") }
        print()
    }
}
```
3. 추후 RubiksCube 구조체를 다룰 때 공통되는 부분을 함수로 묶어 처리할 수 있도록 아래 메소드들을 선언한다.
* getLayer(): 매개변수 값에 따라 특정 큐브 면의 해당 줄(layer)을 String의 배열 형식으로 리턴한다.
* replaceLayer(): 큐브가 회전함에 따라 매개변수에 해당하는 위치의 특정 큐브 면의 줄의 값을 바꾼다. 이때 새롭게 바뀌는 값이 큐브 면의 행(row)이냐, 열(column)이냐에 따라 매개변수 rhs의 타입을 다르게 해준다.
* rotateFaceCW() & rotateFaceCCW(): 회전 방향이 시계 방향이냐, 반시계 방향이냐에 따라 회전 기호에 해당되는 면의 값을 바꾼다.
```Swift
func getLayer(for position: Position) -> [String] {
    switch position {
    case .top:
        return self.topLayer
    case .middle:
        return self.middleLayer
    case .bottom:
        return self.bottomLayer
    }
}

mutating func replaceLayer(with position: Position, of rhs: Side) {
    switch position {
    case .top:
        self.topLayer = rhs.topLayer
    case .middle:
        self.middleLayer = rhs.middleLayer
    case .bottom:
        self.bottomLayer = rhs.bottomLayer
    }
}

mutating func replaceLayer(with position: Position, of rhs: [String]) {
    switch position {
    case .top:
        self.topLayer = rhs
    case .middle:
        self.middleLayer = rhs
    case .bottom:
        self.bottomLayer = rhs
    }
}

mutating func rotateFaceCW() {
    let tempSide = self
    self.topLayer = [tempSide.bottomLayer[0], tempSide.middleLayer[0], tempSide.topLayer[0]]
    self.middleLayer = [tempSide.bottomLayer[1], tempSide.middleLayer[1], tempSide.topLayer[1]]
    self.bottomLayer = [tempSide.bottomLayer[2], tempSide.middleLayer[2], tempSide.topLayer[2]]
}

mutating func rotateFaceCCW() {
    let tempSide = self
    self.topLayer = [tempSide.topLayer[2], tempSide.middleLayer[2], tempSide.bottomLayer[2]]
    self.middleLayer = [tempSide.topLayer[1], tempSide.middleLayer[1], tempSide.bottomLayer[1]]
    self.bottomLayer = [tempSide.topLayer[0], tempSide.middleLayer[0], tempSide.bottomLayer[0]]
}
```
4. 루빅스 큐브를 나타내는 RubiksCube 구조체 내에 면의 위치의 앞글자를 따 Side 타입의 U, L, F, R, B, D를 프로퍼티로 선언한다.
```Swift
var U, L, F, R, B, D: Side
```
5. 6면체를 펼쳐 출력할 수 있는 printCube() 메소드를 선언한다. 이때 평면 6면체 큐브의 가운데 부분인 L~B는 한번에 한면을 인쇄하는 방식이 아닌, (topLayer)(공백)(topLayer)(공백)...(topLayer)을 출력 후 그 다음 줄에 같은 방식으로 middleLayer의 출력을 처리해주어야 하므로 두 번의 for문을 통해 출력을 처리해주었다.
```Swift
func printCube(_ cube: RubiksCube) {
    cube.U.printOneSide(leftPadding: 16)
    /// 줄간격 한칸
    print()
    for position in Position.allCases {
        for side in [cube.L, cube.F, cube.R, cube.B] {
            print(" ", terminator: "")
            side.getLayer(for: position).forEach { print($0, terminator: " ") }
            print(String(repeating: " ", count: 3), terminator: "")
        }
        print()
    }
    /// 줄간격 한칸
    print()
    cube.D.printOneSide(leftPadding: 16)
    print()
}
```
6. 사용자 입력값에 따라 큐브를 동작하게 하는 turnCube() 메소드를 선언한다. 움직이는 방향에 따라 하위 모듈 메소드를 만들어 호출해 사용할 수 있도록 했다. cube 프로퍼티를 수정해야 하므로 메소드 앞에 mutating 키워드를 붙인다.
```Swift
mutating func turnCube(_ moveNotation: String) -> RubiksCube? {
    switch moveNotation {
    /// 가장 윗줄을 왼쪽으로 한 칸 밀기
    case MoveNotation.up.rawValue:
        U.rotateFaceCW()
        return turnLeft(position: .top)
    /// 가장 윗줄을 오른쪽으로 한 칸 밀기
    case MoveNotation.upCCW.rawValue:
        U.rotateFaceCCW()
        return turnRight(position: .top)
    /// 가장 왼쪽줄을 아래로 한 칸 밀기
    case MoveNotation.left.rawValue:
        L.rotateFaceCW()
        return pushDown(col: 0, Bcol: 2)
    /// 가장 왼쪽줄을 위로 한 칸 밀기
    case MoveNotation.leftCCW.rawValue:
        L.rotateFaceCCW()
        return pushUp(col: 0, Bcol: 2)
    /// 가장 앞쪽줄을 오른쪽으로 한 칸 밀기
    case MoveNotation.front.rawValue:
        F.rotateFaceCW()
        return pushDown(Lcol: 2, Rcol: 0, Uposition: .bottom, Dposition: .top)
    /// 가장 앞쪽줄을 왼쪽으로 한 칸 밀기
    case MoveNotation.frontCCW.rawValue:
        F.rotateFaceCCW()
        return pushUp(Lcol: 2, Rcol: 0, Uposition: .bottom, Dposition: .top)
    /// 가장 오른쪽줄을 위로 한 칸 밀기
    case MoveNotation.right.rawValue:
        R.rotateFaceCW()
        return pushUp(col: 2, Bcol: 0)
    /// 가장 오른쪽줄을 아래로 한 칸 밀기
    case MoveNotation.rightCCW.rawValue:
        R.rotateFaceCCW()
        return pushDown(col: 2, Bcol: 0)
    /// 가장 뒷쪽줄을 왼쪽으로 한 칸 밀기
    case MoveNotation.back.rawValue:
        B.rotateFaceCW()
        return pushUp(Lcol: 0, Rcol: 2, Uposition: .top, Dposition: .bottom)
    /// 가장 뒷쪽줄을 오른쪽으로 한 칸 밀기
    case MoveNotation.backCCW.rawValue:
        B.rotateFaceCCW()
        return pushDown(Lcol: 0, Rcol: 2, Uposition: .top, Dposition: .bottom)
    /// 가장 아랫줄을 오른쪽으로 한 칸 밀기
    case MoveNotation.down.rawValue:
        D.rotateFaceCW()
        return turnRight(position: .bottom)
    /// 가장 아랫줄을 왼쪽으로 한 칸 밀기
    case MoveNotation.downCCW.rawValue:
        D.rotateFaceCCW()
        return turnLeft(position: .bottom)
    default:
        return nil
    }
}
```
7. 사용자 입력값을 배열로 가공하는 splitNotation() 함수를 선언한다.
* 반시계 방향 회전: 문자열 뒤에 프라임 기호(')가 위치하는 경우, 해당 문자열과 기호를 묶어 함께 배열에 추가한다.
* 더블턴: 문자열 뒤에 2에 위치하는 경우, 해당 문자열을 두번 배열에 추가한다.
```Swift
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
```
8. 사용자 입력값에 따라 다르게 동작하는 enterNotation() 함수를 선언한다.
9. 키보드 입력을 받기 전 'CUBE>'를 콘솔에 표시하기 위해 print() 함수를 사용한다. 이때 terminator 인자를 사용해 줄바꿈이 되지 않도록 한다.
```Swift
print("CUBE>", terminator: " ")
var input = readLine() ?? ""
```
10. if문을 사용해 사용자 입력값이 "Q"이면 경과 시간, 동작 횟수, 작별 인사를 출력하고 프로그램이 더 이상 이어지지 않게 한다. (= 프로그램을 종료한다.)
```Swift
if input == "Q" {
    print("⌛️ 경과 시간: \(getElapsedTime())")
    print("💬 총 \(moves)번 움직이셨네요!")
    print("그럼 다음에 또 만나요 👋")
}
```
11. 입력값이 "Q"가 아니라면 위에서 선언한 splitNotation() 함수를 호출해 사용자 입력값을 배열로 끊어준 후, 배열 내부 아이템 각각에 turnCube() 메소드를 forEach 클로저를 사용해 호출한다. forEach 클로저가 한번 작동할 때마다 전역 변수 moves에 1을 더해 프로그램 종료 시 출력할 동작 횟수를 계산한다. "Q"가 입력되기 전까지 계속 프로그램을 이어갈 수 있도록 enterMoveNotation() 함수를 재귀호출한다.
```Swift
...
} else {
    let inputArray = splitNotation(str: input)
    inputArray.forEach { item in
        print()
        print(item)
        if let safeCube = rubiksCube.turnCube(item) {
            rubiksCube.printCube(safeCube)
        }
        moves += 1
    }
    ...
    } else {
        enterNotation()
    }
}
```
12. RubiksCube 타입의 rubiksCube 인스턴스 생성한다. 초기 큐브 상태를 출력하기 위해 printCube() 메소드를 호출한 후, 위에서 선언한 enterMoveNotation() 함수를 호출한다.
```Swift
var rubiksCube = RubiksCube(
    U: Side(topLayer: ["B", "B", "B"], middleLayer: ["B", "B", "B"], bottomLayer: ["B", "B", "B"]),
    L: Side(topLayer: ["W", "W", "W"], middleLayer: ["W", "W", "W"], bottomLayer: ["W", "W", "W"]),
    F: Side(topLayer: ["O", "O", "O"], middleLayer: ["O", "O", "O"], bottomLayer: ["O", "O", "O"]),
    R: Side(topLayer: ["G", "G", "G"], middleLayer: ["G", "G", "G"], bottomLayer: ["G", "G", "G"]),
    B: Side(topLayer: ["Y", "Y", "Y"], middleLayer: ["Y", "Y", "Y"], bottomLayer: ["Y", "Y", "Y"]),
    D: Side(topLayer: ["R", "R", "R"], middleLayer: ["R", "R", "R"], bottomLayer: ["R", "R", "R"])
)

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
```

### 추가 구현 기능

#### 경과 시간 출력

1. Date 형식의 start를 선언함으로써 프로그램 시작 시간을 구한다.
```Swift
let start = Date()
```
2. 경과 시간을 구하는 getElapsedTime() 함수를 선언한다. start로부터 프로그램 종료 시점까지의 timeInterval을 구해 시, 분, 초에 따라 각각 가공한다. 시 혹은 분의 값이 있을 경우 함께 리턴하고 그렇지 않은 경우 초의 값만 리턴한다.
```Swift
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
```
3. 프로그램이 종료되는 분기에 getElapsedTime() 함수를 호출해 사용한다.
```Swift
if input == "Q" {
    print("⌛️ 경과 시간: \(getElapsedTime())")
    print("💬 총 \(moves)번 움직이셨네요!")
    print("그럼 다음에 또 만나요 👋")
}
```

#### 무작위 섞기 기능

1. RubiksCube 구조체 내에 큐브를 무작위로 섞는 scrambleCube() 메소드를 추가한다. for문을 통해 랜덤한 회전 기호를 매개변수로 30번 turnCube() 메소드를 호출할 수 있게 했다.
```Swift
mutating func scrambleCube() -> RubiksCube {
    var scrambledCube = self
    for _ in 1...30 {
        guard let safeNotation = MoveNotation.allCases.randomElement()?.rawValue else { fatalError() }
        if let safeCube = turnCube(safeNotation) {
            scrambledCube = safeCube
        }
    }
    return scrambledCube
}
```
2. if문을 사용해 사용자 입력값이 "S"이면 큐브를 무작위로 섞는다. "Q"가 입력되기 전까지 계속 프로그램을 이어갈 수 있도록 enterMoveNotation() 함수를 재귀호출한다.
```Swift
...
} else if input == "S" {
    rubiksCube.printCube(rubiksCube.scrambleCube())
    enterNotation()
}
```

#### 성공시 축하 메시지, 자동 종료

1. Side 구조체 내에 큐브의 한 면을 맞췄는지 확인하는 checkSideSolved() 메소드를 선언한다.
```Swift
func checkSideSolved() -> Bool {
    return self.topLayer == self.middleLayer && self.middleLayer == self.bottomLayer
}
```
2. 큐브의 6면이 모두 맞췄는지 확인하는 checkSolved() 함수를 선언한다.
```Swift
func checkSolved() -> Bool {
    return rubiksCube.U.checkSideSolved() && rubiksCube.L.checkSideSolved() && rubiksCube.F.checkSideSolved() && rubiksCube.R.checkSideSolved() && rubiksCube.B.checkSideSolved() && rubiksCube.D.checkSideSolved()
}
```
3. enterNotation() 함수 내에서 if문을 사용해 checkSolved()의 값이 true이면 경과 시간 및 축하 메시지를 출력하고 프로그램을 종료한다.
```Swift
if checkSolved() {
    print("⌛️ 경과 시간: \(getElapsedTime())")
    print("축하합니다! \(moves)번만에 큐브를 맞추셨어요 🥳")
} else {
    enterNotation()
}
```
