import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

// k는 전역변수임을 나타내기 위해 흔히 사용하는 접두사이다.
// seedColor를 주면 다양한 색조의 색상 구성표를 자동으로 생성한다.
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDartColorScheme = ColorScheme.fromSeed(
  // 기본적으로 brightness이 light에 최적화 되어 있기 때문에 dark 모드에서는 직접 지정해 줘야 한다.
  brightness:  Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(
    // 해당 MaterialApp이 앱의 진입점으로 모든 위젯을 포함하고 있다.
    MaterialApp(
      // 다크모드 색상을 지정해 준다.
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDartColorScheme,
        // force unwrapping 하는 곳이 있기 때문에 동일하게 margin 값을 지정해 줘야 한다.
        cardTheme: const CardTheme().copyWith(
          color: kDartColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        // ElevatedButtonThemeData는 copyWith이 없다.
        // 다만 style하나만 설정해 주면 된다.
        elevatedButtonTheme: ElevatedButtonThemeData(
          // 여기서는 ElevatedButton.styleFrom()를 사용하여 설정한다.
          style: ElevatedButton.styleFrom(
            foregroundColor: kDartColorScheme.onPrimaryContainer,
            backgroundColor: kDartColorScheme.primaryContainer,
          ),
        ),
      ),
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
        ),
        // 마찬가지로 copyWith를 사용하는 것이 편리하다.
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        // ElevatedButtonThemeData는 copyWith이 없다.
        // 다만 style하나만 설정해 주면 된다.
        elevatedButtonTheme: ElevatedButtonThemeData(
          // 여기서는 ElevatedButton.styleFrom()를 사용하여 설정한다.
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        // 앱에서 사용하는 text의 스타일을 일괄적으로 수정할 수 있다.
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
          ),
        ),
      ),
      // ThemeMode를 light나 dark로 설정하면, 사용자의 설정을 무시하고 해당 모드를 강제할 수도 있다.
      // default가 system이라 따로 설정할 필요는 없다.
      // themeMode: ThemeMode.system,
      home: const Expenses(),
    ),
  );
}
