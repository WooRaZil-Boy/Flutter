import 'package:flutter/material.dart';
import 'constants.dart';
import 'home.dart';

void main() {
  // Widget Initialization: Flutter의 모든 여정은 Widget으로 시작된다.
  // runApp() 함수는 Root Widget인 'Yummy'의 인스턴스를 받아 앱을 초기한다.
  runApp(const Yummy());
}

// Yummy 위젯을 StatefulWidget으로 변환한다.
// 'StatelessWidget'에서 'StatefulWidget'으로 변환되면 createState() 구현이 추가된다.
// 또한 '_YummyState' 상태 클래스를 생성한다.
// 이 클래스는 Widget의 life cycle 동안 변경될 수 있는 가변 데이터를 저장한다.
class Yummy extends StatefulWidget {
  const Yummy({super.key});

  @override
  State<Yummy> createState() => _YummyState();
}

class _YummyState extends State<Yummy> {
  // single source of truth를 위한 테마를 지정한다.
  ThemeMode themeMode = ThemeMode.light;
  ColorSelection colorSelected = ColorSelection.pink;

  void changeThemeMode(bool useLightMode) {
    setState(() {
      // 사용자 선택에 따라 테마 모드를 업데이트한다.
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void changeColor(int value) {
    setState(() {
      // 사용자 선택에 따라 테마 색상을 업데이트한다.
      colorSelected = ColorSelection.values[value];
    });
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Yummy';

    // 'Yummy' Widget은 'MaterialApp' Widget을 구성하여 Material Design 시스템 외관을 부여한다.
    return MaterialApp(
      title: appTitle,
      // 디버그 배너 노출 여부를 설정한다.
      debugShowCheckedModeBanner: false, // Uncomment to remove Debug banner
      themeMode: themeMode,
      theme: ThemeData(
          colorSchemeSeed: colorSelected.color,
          useMaterial3: true,
          brightness: Brightness.light),
      darkTheme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      // 앱이 커지면, 위젯을 별도 파일로 분리하여 관리하는 것이 좋다.
      home: Home(
        changeTheme: changeThemeMode,
        changeColor: changeColor,
        colorSelected: colorSelected,
      ),
    );
  }
}
