import 'package:flutter/material.dart';
// FooderlichTheme 테마를 가져왔습니다.
import 'fooderlich_theme.dart';
import 'home.dart';

void main() {
  // Flutter의 모든 것은 위젯으로 시작됩니다. runApp()은 루트 위젯인 Fooderlich를 받습니다.
  runApp(const Fooderlich());
}

class Fooderlich extends StatelessWidget {
  // 모든 StatelessWidget은 build() 메서드를 재정의해야 합니다.
  const Fooderlich({super.key});

  @override
  Widget build(BuildContext context) {
    // 테마를 저장하는 변수를 정의했습니다.
    final theme = FooderlichTheme.dark();

    // Material Design 시스템 룩앤필을 제공하기 위해 MaterialApp 위젯을 컴포밍하는 것으로 시작합니다.
    return MaterialApp(
      // MaterialApp 위젯의 theme 프로퍼티를 추가했습니다.
      theme: theme,
      title: 'Fooderlich',
      home: const Home(),
    );
  }
}
