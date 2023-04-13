import 'package:bloc_named/show_me_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter/counter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // BlocProvider를 사용해 cubit을 생성하면, 필요 없어질 경우 자동으로 close 한다.
  // 하지만 여기에서는 BlocProvider로 생성하지 않았기 때문에 close도 별도로 해야 한다.
  // 따라서, 이를 위해 StatefulWidget으로 변경한다.
  final CounterCubit _counterCubit = CounterCubit();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anonymous Route',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        // ShowMeCounter는 MyHomePage의 자식이 아니다.
        // 이번 경우는 anonymous route access와 달리, MyHomePage와 ShowMeCounter 모두에게 Cubit 객체를 전달해야 한다.
        '/': (context) => BlocProvider.value(
              value: _counterCubit,
              child: MyHomePage(),
            ),
        '/counter': (context) => BlocProvider.value(
              value: _counterCubit,
              child: ShowMeCounter(),
            )
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
