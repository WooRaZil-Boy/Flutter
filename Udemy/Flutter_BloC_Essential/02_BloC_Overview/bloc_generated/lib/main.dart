import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter/counter_cubit.dart';
import 'show_me_coutner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterCubit _counterCubit = CounterCubit();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anonymous Route',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: _counterCubit,
                child: MyHomePage(),
              )
            );
          case '/counter':
            return MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: _counterCubit,
                child: ShowMeCounter(),
              )
            );
          default:
            return null;
        }
      },
    );
  }

  @override
  void dispose() {
    _counterCubit.close();
    super.dispose();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/counter');
              },
              child: Text(
                'Show Me Counter',
                style: TextStyle(fontSize: 20.0),
              )
            ),
          SizedBox(height: 20.0),
          ElevatedButton(
              onPressed: () {
                BlocProvider.of<CounterCubit>(context).increment();
              },
              child: Text(
                'Increment Counter',
                style: TextStyle(fontSize: 20.0),
              )
            ),
          ],
        ),
      ),
    );
  }
}

// 사실 지금까지의 모든 문제는 더 상위 위젯을 감싸는 global access로 풀 수 있다.
// cubit이나 BloC를 전체 위젯 트리에서 사용할 수 있게 된다.
// return BlocProvider<T> (
//    create: (_) => T(),
//    child: MaterialApp(
//      ...
//    )
// );
// 하지만, 모든 클래스를 global로 사용할 필요도 없고 바람직한 방법이 아니다.