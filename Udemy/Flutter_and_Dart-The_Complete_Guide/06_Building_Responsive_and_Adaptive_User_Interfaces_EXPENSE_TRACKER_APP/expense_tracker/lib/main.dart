import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses.dart';
// import 'package:flutter/services.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  // 디바이스가 회전을 했을 때, 앱의 레이아웃을 업데이트하지만 여기서는 최적화되어 있지는 않다.
  // 반응형 앱이란 레이아웃과 스타일이 사용 가능한 공간과 너비에 맞춰 조정되는 앱이다(세로 / 가로 모드).

  // 비동기로 데이터를 다룬다음 runApp을 실행해야 하는 경우 반드시 WidgetsFlutterBinding.ensureInitialized()를 호출해야 한다.
  // runApp의 시작 지점에서 Flutter 엔진과 위젯의 바인딩이 완료되지 않았을 수도 있기 때문이다.
  // 해당 코드를 사용하면, runApp을 호출하기 전에 필요한 모든 비동기 작업을 수행할 수 있다.
  // WidgetsFlutterBinding.ensureInitialized();
  // // 이를 처리하는 가장 쉬운 방법은 하나의 모드로 고정시키는 것이다.
  // // SystemChrome.setPreferredOrientations를 사용하면 지원하는 방향을 지정할 수 있다.
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //   ],
  // ).then((fn) {
  //   // 여기에서 runApp의 모든 코드가 실행되도록 감싸면 된다.
  // });

  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
      ),
      // themeMode: ThemeMode.system, // default
      home: const Expenses(),
    ),
  );
}
