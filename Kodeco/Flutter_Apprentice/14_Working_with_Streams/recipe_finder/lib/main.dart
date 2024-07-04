import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'package:provider/provider.dart';
import 'data/memory_repository.dart';
import 'ui/main_screen.dart';

import 'data/repository.dart';
import 'network/recipe_service.dart';
import 'network/service_interface.dart';

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
      providers: [
        // Repository()를 제공할 때 생성하는 리포지토리 유형을 변경할 수 있습니다.
        // 여기서는 MemoryRepository()를 사용하고 있지만 다음 장에서 설명하는 것처럼 다른 것을 사용할 수도 있습니다.
        Provider<Repository>(
          lazy: false,
          create: (_) => MemoryRepository(),
        ),
        // RecipeService()를 사용하지만 API 속도 제한에 문제가 발생하기 시작하면
        // MockService()로 전환할 수 있습니다.
        Provider<ServiceInterface>(
          create: (_) => RecipeService.create(),
          lazy: false,
        ),
      ],
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
