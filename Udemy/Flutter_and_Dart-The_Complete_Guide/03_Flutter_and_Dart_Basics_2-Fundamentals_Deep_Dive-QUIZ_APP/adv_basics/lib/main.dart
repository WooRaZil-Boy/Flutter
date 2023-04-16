import 'package:adv_basics/start_screen.dart';
import 'package:flutter/material.dart';

// main은 특수 함수로 디바이스에서 앱이 시작되면 자동으로 감지되고 Dart가 실행된다.
void main(List<String> args) {
  // main 내부에서는 flutter가 제공하는 runApp 함수를 사용하여 앱을 실행한다.
  // MaterialApp을 실행하면서 인수로 여러 옵션들을 줄 수 있다.
  // MaterialApp 자체는 아무것도 보여주지 않는다. Widget을 추가해 줘야 한다.
  runApp(
    MaterialApp(
      // Scaffold를 custom Widet에 포함할 수도 있다.
      home: Scaffold(
        // Gradeint를 추가하기 위해 Container로 감싼다.
        body: Container(
          decoration: const BoxDecoration(
            // gradient를 추가했지만, 하위의 StartScreen 위젯 크기 만큼 적용된다. 
            // 따라서 전체 화면에 적용하고 싶다면 StartScreen 크기를 조정해 줘야 한다.
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              // List는 Generic으로 타입을 지정해 줄 수 있다.
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
            ),
          ),
          child: const StartScreen(),
        ),
      ),
    ),
  );
  // 괄호를 닫을 때마다 ,를 붙여줘야 자동정렬이 제대로 작동한다.
}
