import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  // 'ThemeButton' 위젯은 'changeThemeMode'라는 함수 매개변수를 필수로 가진 생성자로 초기화된디.
  const ThemeButton({
    Key? key,
    required this.changeThemeMode,
  }) : super(key: key);

  // 'changeThemeMode'는 버튼을 누를 때 호출될 콜백 함수로, 매개변수로 전달된다. 
  // 이 함수는 부모 Widhet에게 brightness 변경을 알려 theme를 적절히 조정할 수 있게 한다.
  final Function changeThemeMode;

  @override
  Widget build(BuildContext context) {
    // 현재 테마 밝기가 밝은지 확인하는 부울 값
    final isBright = Theme.of(context).brightness == Brightness.light;

    // 'IconButton' 위젯은 'isBright' 부울 값에 따라 라이트 모드 또는 다크 모드 아이콘을 표시한다.
    return IconButton(
      icon: isBright 
          ? const Icon(Icons.dark_mode_outlined)
          : const Icon(Icons.light_mode_outlined),
      // 'IconButton'을 누르면, 'changeThemeMode'를 호출하여 테마의 밝기를 전환한다.
      onPressed: () => changeThemeMode(!isBright),
    );
  }
}




