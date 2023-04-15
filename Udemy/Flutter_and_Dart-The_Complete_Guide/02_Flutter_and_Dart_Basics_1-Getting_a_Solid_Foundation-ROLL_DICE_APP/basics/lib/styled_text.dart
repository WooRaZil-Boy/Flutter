import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  // 텍스트는 자체는 동적으로 설정되지만, 색과 글꼴 크기 등을 조정할 수 있어야 한다. 이를 위해 변수를 받는 생성자를 구성한다.
  // const StyledText(String text, {super.key}): text = text; 로 쓸 수도 있다. 그러나 너무 장황하므로 짧은 문법을 사용한다.
  // text를 받아 생성하므로 잠재적인 상수 객체가 될 수 없다. 따라서 const를 사용할 수 없다.
  // text를 final로 선언하면, 내부적으로는 변하지 않고, 항상 같은 객체일 것이 보장되므로 const를 다시 사용할 수 있다.
  const StyledText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    // 파란 물결선이 표시 될 수 있는데, 이는 error가 아닌 warning 이다. 문제는 없지만 수정이 권장된다.
    // const를 사용하면 앱의 런타임 성능을 최적화할 수 있다.
    // 아래에서 const를 사용하여 Text 위젯을 생성하면, 해당 위젯이 메모리에 저장되게 된다.
    // 이때, 같은 Text 위젯을 여러번 사용한다면 재생성하지 않고, 메모리에 저장된 위젯을 사용하게 된다.
    // 즉, const를 사용하면 동일한 값을 재사용할 수 있고 메모리에서 데이터를 중복하는 것을 방지할 수 있다.
    // 따라서 앱의 메모리 효율이 높아지고, 전반적인 성능이 향상된다.
    // 물론 여기서는 다른 곳에서 재사용하지 않아서 const를 사용해도 큰 이점은 없지만, 해가 되는 것도 없다.

    // " 또는 ' 를 사용할 수 있지만, '가 더 일반적이다.
    // 위젯을 추가할 때는 refactor 메뉴를 사용하는 것이 편리하다.
    // 또한 모든 닫는 괄호 뒤에는 , 와 ; 를 써주는 것이 좋다. 그리고 Format Document 옵션을 사용하면 자동으로 정렬해 준다.
    // , 와 ; 를 넣어주면 자동으로 정렬될 때 예상대로 잘 정렬이 되어 읽기 쉬워진다.
    return Text(
      text,
      style: const TextStyle(
        fontSize: 28,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}