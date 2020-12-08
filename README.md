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
var cube: [[String]] = [["R", "R", "W"], ["G", "C", "W"], ["G", "B", "B"]]
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
4-1. 키보드 입력을 받기 전 'CUBE>'를 콘솔에 표시하기 위해 print() 함수를 사용한다. 이때 terminator 인자를 사용해 줄바꿈이 되지 않도록 한다.
```Swift
print("CUBE>", terminator: " ")
var input = readLine() ?? ""
```
4-2. if문을 사용해 사용자 입력값이 "Q"이면 "Bye👋"를 출력하고 프로그램이 더 이상 이어지지 않게 한다. (= 프로그램을 종료한다.)
4-3. 입력값이 "Q"가 아니라면 String을 Array로 가공해 여러 문자도 순서대로 처리해줄 수 있게 한다. 이때 문자에 아포스트로피(')가 포함된 경우를 고려해야 하므로 while문을 이용해 적절한 위치에서 String을 끊어갈 수 있도록 조치했다.
```Swift
var inputArray = [String]()
while input.count != 0 {
    let firstChar = input.removeFirst()
    input.first == "'" ? inputArray.append("\(firstChar)\(input.removeFirst())") : inputArray.append("\(firstChar)")
}
```
4-4. 정의된 최소 단위의 문자열로 쪼개진 inputArray 배열의 내부 아이템을 매개변수로 turnCube() 메소드를 호출하기 위해 forEach 클로저를 사용한다.
```Swift
inputArray.forEach { input in
    print()
    print(input)
    myCube.printCube(myCube.turnCube(input))
}
```
4-5. "Q"가 입력되기 전까지 계속 프로그램을 이어갈 수 있도록 enterMoveNotation() 함수를 재귀호출한다.

5. FlatCube 타입의 myCube 인스턴스 생성한다. 초기 큐브 상태를 출력하기 위해 printCube() 메소드를 호출한 후, 위에서 선언한 enterMoveNotation() 함수를 호출한다.
```Swift
var myCube = FlatCube()
myCube.printCube(myCube.cube)
enterMoveNotation()
```
