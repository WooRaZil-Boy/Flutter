// 코드 자체는 해당 runApp이 어느 라이브러리에 있는지 알 수 없다. import 해서 특정 라이브러리를 지정해 줘야 한다.
import 'package:flutter/material.dart';

// Dart의 진입점으로 main 함수는 반드시 필요하다.
void main(List<String> args) {
  // Flutter의 함수로 사용자 인테페이스를 화면에 보여준다.
  // 함수 정의 때 사용하는 멤버를 argument, 함수 호출 때 사용하는 멤버를 parameter라고 한다.
  // Flutter 앱이 실행되기 위해서는 위젯 트리가 필요하다. 여러 위젯들을 서로 연결하여 사용자 인터페이스를 구축한다.
  runApp(); 
}