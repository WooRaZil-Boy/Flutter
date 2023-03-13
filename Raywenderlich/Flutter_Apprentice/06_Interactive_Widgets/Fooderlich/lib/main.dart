import 'package:flutter/material.dart';
// 하위 위젯이 상태 객체에 액세스할 수 있도록 Fooderlich의 최상위 레벨에 TabManager를 제공해야 합니다.
import 'package:provider/provider.dart';
import 'models/models.dart';

import 'fooderlich_theme.dart';
import 'home.dart';

void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatelessWidget {
  const Fooderlich({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FooderlichTheme.light();
    return MaterialApp(
      theme: theme,
      title: 'Fooderlich',
      // MultiProvider를 Home의 속성으로 할당합니다.
      // 그러면 Home의 하위 위젯이 액세스할 수 있는 provider 목록을 받습니다.
      // 위젯 트리에 둘 이상의 Provider를 제공해야 하는 경우 MultiProvider를 사용하세요.
      // 나중에 항목 목록을 관리하기 위해 GroceryManager 상태 객체도 추가할 수 있습니다.
      home: MultiProvider(
        providers: [
          // ChangeNotifierProvider는 탭 인덱스 변경을
          // 수신하고 리스너에 알리는 TabManager의 인스턴스를 생성합니다.
          ChangeNotifierProvider(create: (context) => TabManager()),
          // Fooderlich의 모든 하위 위젯이 GroceryManager를 수신하거나 액세스할 수 있습니다.
          ChangeNotifierProvider(create: (context) => GroceryManager()),
        ],
        child: const Home(),
      )
    );
  }
}
