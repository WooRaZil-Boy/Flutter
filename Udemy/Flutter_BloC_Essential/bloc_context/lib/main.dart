import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/counter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Context',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
          child: ChildWidget(),
        ),
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  const ChildWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          // Bloc이 제공된 동일한 context에서는 Bloc에 접근할 수 없기 때문에 BlocProvider.of가 child의 buildContext에서 호출되도록 해야 한다.
          // 즉, 주어진 context부터 '시작'해서 위젯 트리를 타고 context를 찾아간다. 여기서의 context는 BlocProvider 생성시의 context가 아니라, build 함수의 context이다.
          // 해결 방안은
          //  1. child widget을 별도의 Widget으로 분리한다. : context가 또 다른 트리 관계를 형성하기 때문에 오류가 발생하지 않는다.
          //  2. Builder widget으로 감싼다.
          '${BlocProvider.of<CounterCubit>(context, listen: true).state.counter}',
          style: TextStyle(fontSize: 52.0),
        ),
        ElevatedButton(
          child: Text(
            'Increment',
            style: TextStyle(fontSize: 20.0),
          ),
          onPressed: () {
            BlocProvider.of<CounterCubit>(context).increment();
          },
        )
      ],
    );
  }
}
