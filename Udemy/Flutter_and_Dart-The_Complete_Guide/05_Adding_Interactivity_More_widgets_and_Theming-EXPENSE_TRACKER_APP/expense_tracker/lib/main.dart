import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

// k는 전역변수임을 나타내기 위해 흔히 사용하는 접두사이다.
// seedColor를 주면 다양한 색조의 색상 구성표를 자동으로 생성한다.
var kColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

void main() {
  runApp(
    // 해당 MaterialApp이 앱의 진입점으로 모든 위젯을 포함하고 있다.
    MaterialApp(
      // Material3를 사용한다. 테마 설정을 위한 수 많은 매개변수들이 있다.
      // 사용자 지정 테마를 만들려면 이런 많은 매개변수에 대한 설정을 해 줘야 하는데, copyWith()를 사용하면 기존 테마를 복사하여 일부만 변경할 수 있다.
      theme: ThemeData().copyWith(
        useMaterial3: true,
        // 아래와 같이 하나씩 일일히 설정할 수도 있지만 ColorScheme를 사용하여 일괄 적용 하도록 하는 것이 좋다.
        // scaffoldBackgroundColor: const Color.fromARGB(255, 220, 189, 252),
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        )
      ),
      home: const Expenses(),
    ),
  );
}