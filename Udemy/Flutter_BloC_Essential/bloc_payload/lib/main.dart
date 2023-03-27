import 'package:bloc_payload/theme/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      // BlocProvider를 위한 context를 찾아야 할 경우, Builder 위젯을 사용할 수 있다.
      // Flutter에서 모든 위젯은 builder() 함수를 가지고 인자값으로 context를 전달한다. 
      // of (여기서는 watch)를 사용하게 되면, 인자로 제공해준 context의 조상 중 가장 가까운 타입(여기서는 BlocProvider)을 찾게 된다.
      // child: Builder 가 없는 경우의 context는 BlocProvider 보다 부모의 context가 되므로 여기서 BlocProvider을 찾지 못하고 오류가 발생한다.
      // Builder로 감싸게 되면, context는 Builder 보다 부모의 context가 되므로, BlocProvider를 찾을 수 있다.
      // Builder 클래스는 내부 위젯들을 새로운 위젯으로 강제적으로 만들며 그 부모의 context로 접근 가능하게 만들어 준다. 
      // 이 외의 해결방법으로 아예 따로 Widget 클래스를 생성해 줄 수 있다.
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Event Payload',
            debugShowCheckedModeBanner: false,
            theme: context.watch<ThemeBloc>().state.appTheme == AppTheme.light
              ? ThemeData.light()
              : ThemeData.dark(),
            home: const MyHomePage(),
          );
        }
      )
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(
            'Change Theme',
            style: TextStyle(fontSize: 24.0),
          ),
          onPressed: () {
            final int randInt = Random().nextInt(10);
            print('randInt $randInt');

            context.read<ThemeBloc>().add(ChangeThemeEvent(randInt: randInt));
          },
        ),
      ),
    );
  }
}
