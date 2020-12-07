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
