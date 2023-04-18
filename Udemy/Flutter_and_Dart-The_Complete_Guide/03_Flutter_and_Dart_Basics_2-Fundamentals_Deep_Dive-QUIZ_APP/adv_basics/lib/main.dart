import 'package:adv_basics/quiz.dart';
import 'package:flutter/material.dart';

// main은 특수 함수로 디바이스에서 앱이 시작되면 자동으로 감지되고 Dart가 실행된다.
void main(List<String> args) {
  // main 내부에서는 flutter가 제공하는 runApp 함수를 사용하여 앱을 실행한다.
  // MaterialApp을 실행하면서 인수로 여러 옵션들을 줄 수 있다.
  // MaterialApp 자체는 아무것도 보여주지 않는다. Widget을 추가해 줘야 한다.
  runApp(const Quiz());
  // 괄호를 닫을 때마다 ,를 붙여줘야 자동정렬이 제대로 작동한다.
}