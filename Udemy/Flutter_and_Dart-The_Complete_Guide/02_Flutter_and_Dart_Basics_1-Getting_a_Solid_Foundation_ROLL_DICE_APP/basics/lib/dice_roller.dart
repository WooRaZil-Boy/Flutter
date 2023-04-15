import 'dart:math';

import 'package:flutter/material.dart';

// rollDice 메서드 내에서 Random()을 직접 호출하면 버튼을 클릭할 때마다 새로운 Random 객체가 생성되어 메모리에 저장된다.
// 물론 생성된 후 바로 버려지기 때문에 큰 문제는 없지만, 불필요하게 객체가 생성/삭제된다.
// 따라서 따로 변수로 선언한 뒤 사용하는 것이 더 효율적이다.
// 각 DiceRoller 위젯 안에 따로 생성할 필요 없이 global로 선언하여 사용할 수 있다.
final randomizer = Random();

// Flutter에서는 StatefulWidget와 State를 분리해야 한다.
class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  // StatefulWidget은 State를 생성하는 createState() 메서드를 반드시 구현해야 한다.
  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

// 밑줄을 사용하면 private가 된다. 해당 파일 내에서만 사용할 수 있다.
class _DiceRollerState extends State<DiceRoller> {
  // 해당 변수를 추가하면, 값이 바뀔 수 있기 때문에 더 이상 해당 GradientContainer 위젯을 const로 생성할 수 없다.
  var currentDiceRoll = 2;

  void rollDice() {
    // 단순히 변수에 값을 할당한다고 해서, 위젯이 해당 값을 감지하지 않는다.
    // StatelessWidget 대신 StatefulWidget을 사용해야 한다.
    // UI를 갱신하려면 StatelessWidget를 추가하는 것뿐만 아니라 build 함수를 호출해야 한다.
    // build 함수가 다시 실행될 때에만 UI가 업데이트 된다. 
    // build 함수는 해당 위젯이 처음 생성될 때와 setState() 메서드가 호출될 때 실행된다.
    // setState함수는 StatefulWidget와 State를 사용하는 경우에만 사용할 수 있다.
    setState(() {
      // 가장 높은 값을 생성자에 전달한다. 여기서의 최대값은 < max가 되므로 제외된다. ex. 6 -> 0 ~ 5
      currentDiceRoll = randomizer.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Image와 Button을 자식으로 사용해야 하는데, Center 위젯에는 child 하나만 추가한다.
    // 따라서 Column을 추가하고, Column의 children에 Image와 Button을 추가한다.
    return Column(
      // Column를 사용하면, 차지할 수 있는 모든 범위를 Column이 차지한다.
      // 따라서 mainAxisSize 혹은 mainAxisAlignment를 사용하여 정렬해야 한다.
      mainAxisSize: MainAxisSize.min,
      children: [
        // image도 동적으로 할당되기 때문에 const를 사용할 수 없다.
        Image.asset(
          // $을 사용하여 interpolation할 수 있다.
          'assets/images/dice-$currentDiceRoll.png',
          width: 200,
        ),
        const SizedBox(height: 20),
        TextButton(
          // onPressed는 함수를 값으로 사용한다. Dart에서는 함수도 객체이다.
          // 익명함수로 처리하거나, 따로 메서드를 만들고 전달할 수 있다.
          // 여기선 함수를 실행하지 않기 때문에 괄호를 추가하지 않는다. 함수 이름을 써서 포인터를 전달할 뿐이다.
          onPressed: rollDice,
          style: TextButton.styleFrom(
            // SizedBox 대신 버튼에 padding을 줄 수도 있다.
            // padding: EdgeInsets.only(
            //   top: 20,
            // ),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 28,
            ),
          ),
          child: const Text(
            'Roll Dice',
          ),
        ),
      ],
    );
  }
}
