import 'package:basics/dice_roller.dart';
import 'package:flutter/material.dart';

// 변수는 데이터 컨테이너이다. 변수명은 소문자로 시작해야 한다.
// var로 선언하면 재할당이 가능하다. 따라서, 위젯 생성자에서 const 키워드를 사용하지 못할 수 있다.
// dart는 변수의 유형을 추론한다. 선언만 하고 할당하지 않으면, dynamic으로 추론한다.
// 일반적으로 dynamic으로 선언되는 것은 피해야 한다.
// 선언만 할 경우에는 컴파일 오류가 발생한다. 이를 피하고 싶으면 optional 하게 선언해야 한다.
// 한 번만 값이 할당되고 바뀌는 일이 없다면 final을 사용하는 것이 좋다. 기본적으로 var 보다는 final을 사용하는 것이 좋다.
// final은 런타임에 값이 할당되어야 한다. 그리고 한 번 할당되면 변경할 수 없다.
// 변수도 const로 선언할 수 있다. final과 비슷하게 변경되지 않지만, 컴파일 타임에 값이 할당되어야 한다.
// 여기서는 해당 값이 런타임에 실행할 필요가 없으므로 const로 사용하는 것이 성능 최적화에 도움이 된다.
const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

// 가독성을 향상 시키고, 코드를 재사용하기 위해 Widget을 분리하는 것이 좋다.
// 그리고 별도의 파일로 관리하는 것이 좋다.

// Dart에서 모든 값은 객체이고, Dart는 객체 지향 언어 이다. 객체는 데이터를 구성하고 논리를 분리한다.
// class는 런타임에 생성될 때 어떤 종류의 데이터가 객체에 저장될지 정의한다. 그리고 메서드가 어떤 객체에 저장될지도 정의한다.
// 따라서 사용자 지정 위젯도 class로 정의한다.

// StatefulWidget은 상태를 관리할 수 있다. 상태는 데이터로 변할 수 있고, 렌더링된 UI에 영향을 미칠 수 있다.
// 하지만 여기서는 상태의 변화가 영향을 미치는 부분이 rollDice밖에 없고, 이를 감지하는 것도 Image와 Button 뿐이다.
// 따라서 전체를 StatefulWidget으로 바꾸는 것이 아니라 두 개의 분리된 위젯으로 나누는 것이 더 편하다.
class GradientContainer extends StatelessWidget {
  // key 인수는 위젯의 식별자로 StatelessWidget으로 전달된다.

  // 생성자에 const를 추가하여 최적화될 수 있는 class라고 알려줄 수 있다.
  // 밑의 List를 받는 방법과 달리 각각 color를 하나씩 받는다.
  const GradientContainer(this.color1, this.color2, {super.key});

  // 생성자는 여러 개 만들 수 있다.
  const GradientContainer.purple({super.key})
      : color1 = Colors.purple,
        color2 = Colors.indigo;

  final Color color1;
  final Color color2;

  // flutter의 widet의 build 메서드를 호출하여 다른 위젯을 찾거나 앱을 실행한다.
  // 따라서 기본적으로 flutter가 위젯 트리에서 위젯을 감지할 때마다 build 메서드를 호출하고 context를 전달한다.
  // context는 전체 위젯 트리에 있는 해당 위젯에 대한 유용한 정보를 포함하고 있는 객체이다.
  // build 메서드는 위젯을 생성하고, 다른 위젯을 포함하는 역할을 한다.
  @override
  Widget build(BuildContext context) {
    return Container(
      // const는 가능한 가장 상위의 Widget에 지정해 주는 것이 좋다.
      decoration: BoxDecoration(
        // LinearGradient의 기본 설정은 왼쪽에서 오른쪽으로 그라데이션이 적용된다.
        gradient: LinearGradient(
          begin: startAlignment,
          end: endAlignment,
          // colors는 List<Color> 타입이다.
          colors: [color1, color2],
        ),
      ),
      child: const Center(
        child: DiceRoller(),
      ),
    );
  }
}

// class GradientContainer extends StatelessWidget {
//   // this.colors로만 쓰면, null이 될 수도 있기 때문에 컴파일 에러가 난다. 해결하는 방법이 여러개 있지만 여기서는 required를 추가한다.
//   const GradientContainer({super.key, required this.colors});

//   // final이라고 해도, List는 변경 가능하다. 따라서, const 키워드가 오류가 날 수 있다.
//   final List<Color> colors;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: startAlignment,
//           end: endAlignment,
//           colors: colors,
//         ),
//       ),
//       child: const Center(
//         child: StyledText('Hello World!'),
//       ),
//     );
//   }
// }
