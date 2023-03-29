import 'package:bloc_anonymous/counter/counter_cubit.dart';
import 'package:bloc_anonymous/show_me_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anonymous Route',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<CounterCubit>(
        create: (context) => CounterCubit(),
        child: const MyHomePage(),
      ),
    );
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
                  // Anonymous route는 route의 이름이 없는, dynamic하게 생성되는 route이다.
                  // Navigator.push()를 사용하면 자식 위젯이 생기는 것이 아니라 새로운 위젯 트리가 생성된다.
                  Navigator.push(
                    context,
                    // value(named)를 사용하면, 이미 존재하는 클래스에 대한 접근을 허용한다.
                    // value 생성자는 자동으로 class를 close 하지 않는다.
                    // 여기에 단순히 context를 사용하면, Navigator의 context가 아닌 상위의 context가 전달되므로 이름을 바꾼다.
                    // 사실 이 context는 따로 사용되지 않으므로, _ 로 표시해도 된다.
                    MaterialPageRoute(builder: (_) {
                      return BlocProvider.value(
                        value: context.read<CounterCubit>(),
                        child: ShowMeCounter(),
                      );
                    }),
                  );
                },
                child: Text(
                  'Show Me Counter',
                  style: TextStyle(fontSize: 20.0),
                )),
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
