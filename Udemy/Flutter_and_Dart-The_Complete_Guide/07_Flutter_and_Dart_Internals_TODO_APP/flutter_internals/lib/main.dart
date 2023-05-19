import 'package:flutter/material.dart';
import 'package:flutter_internals/keys/keys.dart';

// import 'package:flutter_internals/ui_updates_demo.dart';

void main() {
  // final 이지만 값을 추가할 수 있다.
  // 여기서는 메모리에 저장된 기존 값을 그대로 사용한다. 새로운 값을 추가할 뿐이다.
  // 메모리에 있는 객체는 동일하다. final은 저장된 객체의 주소를 변경할 수 없다는 의미이다. 메모리의 기존 값은 수정할 수 있다.

  // 하지만 final을 사용하지 않고 const를 사용하면, 아래 코드에서도 오류가 발생한다.
  // cannot add to an unmodifiable list
  // const를 사용하면, 값 자체도 조작할 수 없게 된다. Widget 앞에 const를 붙이는 것도 동일하다.
  final numbers = [1, 2, 3];
  numbers.add(4);

  // 그러나 숫자 자체를 새로 설정하려면 오류가 발생한다.
  // = 를 사용하면 새로운 리스트를 생성한다.
  // 아래와 같이 사용하기 위해서는 var을 사용해야 한다.
  // 변수에 저장되는 것은 메모리에 있는 데이터의 주소이다.
  // 변수에 값을 덮어쓰면, 새 객체가 생성되어 새 주소와 함께 메모리에 저장된다. 즉, 변수는 메모리의 다른 객체를 가리키게 된다.
  // 하지만, add() 함수를 사용하면, 주소가 바뀌지 않고 메모리에서 기존 리스트를 수정한다.
  // 따라서 메모리 주소가 바뀌지 않기 때문에 var 대신 final을 사용할 수 있다.
  // numbers = [4, 5, 6]; // Error

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Internals'),
        ),
        // body: const UIUpdatesDemo(),
        body: Keys(),
      ),
    );
  }
}

// 3가지의 tree가 있다. Widget Tree, Element Tree, Render Tree
// - Widget Tree : 코드에 있는 위젯의 조합.
// - Element Tree : Widget Tree의 번역. 위젯에 대한 메모리 정보를 가지고 있다. 객체의 인스턴스 정보가 아닌 클래스 정보를 가진다.
//  Element Tree는 위젯에 대한 context로 구성되어 있다.
//  Element Tree로 요구되는 UI 업데이트를 효율적으로 결정할 수 있다. 처음 build 함수가 호출될 때, Element Tree가 생성되며 적절한 요소를 메모리에 저장한다.
//  build 함수는 매우 빈번하게 재호출되기 때문에, Element Tree의 요소를 재사용한다. 어떤 UI가 화면에 렌더링 될지 결정한다.
// - Render Tree : UI building block의 조합으로, 실제 UI를 화면에 그린다. Element Tree랑 연결되어 있으며, Widget Tree랑은 연결되어 있지 않다.
//  UI 업데이트가 필요한 요소만 업데이트한다. Element Tree는 UI 업데이트가 필요한 요소를 결정하고, Render Tree는 UI 업데이트를 수행한다.
