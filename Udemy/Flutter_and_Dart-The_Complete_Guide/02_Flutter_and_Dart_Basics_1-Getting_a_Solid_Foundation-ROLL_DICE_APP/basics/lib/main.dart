import 'package:basics/gradient_container.dart';
// 코드 자체는 해당 runApp이 어느 라이브러리에 있는지 알 수 없다. import 해서 특정 라이브러리를 지정해 줘야 한다.
import 'package:flutter/material.dart';

// Dart의 진입점으로 main 함수는 반드시 필요하다.
void main(List<String> args) {
  // Flutter의 runApp 함수로 사용자 인테페이스를 화면에 보여준다.
  // 함수 정의 때 사용하는 멤버를 argument, 함수 호출 때 사용하는 멤버를 parameter라고 한다.
  // Flutter 앱이 실행되기 위해서는 위젯 트리가 필요하다. 여러 위젯들을 서로 연결하여 사용자 인터페이스를 구축한다.

  // MaterialApp은 생성자를 호출한다. 시작점으로 사용하는 주요 위젯이다.
  runApp(
    const MaterialApp(
      // 많은 앱들이 여러 개의 화면을 사용하고, 심지어 해당 앱에서도 한 개는 사용하고 있다.
      // Scaffold는 이런 화면의 기본적인 레이아웃을 제공한다.
      home: Scaffold(
        // backgroundColor로 배경색을 지정할 수 있으며, Color? 타입이므로 null을 넣을 수도 있다.
        // 그라데이션은 backgroundColor으로 지정할 수 없다.

        // Container는 위젯을 감싸는 역할을 한다. 위젯을 감싸는 것은 레이아웃을 조정할 때 유용하다.
        // Container는 const를 사용할 수 없다. const는 컴파일 타임에 값을 결정할 수 있어야 한다.
        // 따라서 이전에 MaterialApp 앞에 지정한 const가 남아 있다면 오류가 발생하여 컴파일이 도지 않는다.
        // 따라서 부모가 아닌 자식의 Widget인 Center 위젯에 const를 지정해 준다.
        // 또 다시 파란 물견선이 표시되는데, Container로 단순히 감싸기만 해서 아무런 의미가 없기 때문이다.
        // 각각의 Widget을 추가하고, type을 확인하여 적절하게 사용해야 한다.
        body: GradientContainer(
          Color.fromARGB(255, 33, 5, 109),
          Color.fromARGB(255, 68, 32, 149),
        ),
      ),
    ),
  );
}

// 어떤 Widget을 사용할지는 Flutter Widget Catalog를 확인해 본다.

// 매개변수는 중괄호로 받기 때문에 ({}) 순서에 상관없이 name만 제대로 되어 있으면 된다.
// 함수 매개변수 는 positional, named, optional 방식이 있다.
//  positional :: (a, b) 순서에 맞게 사용해야 한다.
//  named :: ({a, b}) 이름을 지정해 주면 순서에 상관없이 사용할 수 있다.
//  optional :: (a, [b]) b는 선택적으로 사용할 수 있으며 default value를 지정할 수 있다.
// named 방식에서 required 키워드를 앞에 붙일 수도 있다. ({ required a, b}) 이 경우 a는 필수로 사용해야 한다.

// Dart는 type safe language이다. 일반적으로 하나의 type을 가지는 게 아니고, 여러 type을 가지고 있다.
//  'Hello World!' : String, Object
//  29 : int, num, Object
//  MaterialApp : MaterialApp, Widget, Object
// Dart에서 모든 값은 Object 이다. Widget도 Object이다.
// 함수를 선언할 때도 type을 지정해 줄 수 있다. ex) void add(int num1, int num2) { ... }

// control + space를 사용하여 assistant를 열 수 있다(xcode 에서의 esc).