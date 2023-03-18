import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'ui/main_screen.dart';

import 'package:provider/provider.dart';
import 'data/memory_repository.dart';
import 'mock_service/mock_service.dart';

Future<void> main() async {
  _setupLogging();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    log('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // MultiProvider는 providers 속성을 사용하여 멀티 프로바이더를 정의합니다.
      providers: [
        // MemoryRepository 유형을 가진 ChangeNotifierProvider를 사용합니다.
        ChangeNotifierProvider<MemoryRepository>(
          // 필요할 때까지 기다리지 않고 리포지토리를 바로 생성하도록 lazy를 false로 설정합니다.
          // 이 설정은 리포지토리를 시작하기 위해 백그라운드 작업을 수행해야 할 때 유용합니다.
          lazy: false,
          create: (_) => MemoryRepository(),
        ),
        // MockService를 사용할 새 Provider를 추가합니다.
        Provider(
          // MockService를 생성하고 create()를 호출하여 JSON 파일을 로드합니다
          // .. 캐스케이드 연산자를 사용합니다.
          create: (_) =>
          MockService()
            ..create(),
          lazy: false,
        ),
      ],
      // 5
      child: MaterialApp(
        title: 'Recipes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MainScreen(),
      ),
    );
  }
}