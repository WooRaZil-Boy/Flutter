import 'dart:developer';

import 'package:cubit2cubit_listener/cubits/color/color_cubit.dart';
import 'package:cubit2cubit_listener/cubits/counter/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorCubit>(
          create: (context) => ColorCubit()
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'cubit2cubit',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyHomePage(),
      ),
    );
  }
}

// 이제는 changeCounter에 argument로 값을 넘겨줘야 하고, 해당 값은 변하는 값이므로 StatefulWidget으로 변경해야 한다.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int incrementSize = 1;

  @override
  Widget build(BuildContext context) {
    // BlocListener를 사용할 수도 있다. BlocListener는 state의 변화를 listen하고 있다가 
    // dialog를 표시하는 등 one time action에 사용한다. 
    // BlocListener는 위젯이기 때문에 state 변화에 따라 무언가를 하는 것이 UI에 비즈니스 로직을 추가하는 것이 아닌가 할 수 있지만,
    // cubit의 함수를 호출하거나, event를 stream에 add하는 것 자체는 비즈니스 로직과는 무관하다.
    return BlocListener<ColorCubit, ColorState>(
      listener: (context, state) {
         if (state.color == Colors.red) {
          incrementSize = 1;
        } else if (state.color == Colors.green) { 
          incrementSize = 10;
        } else if (state.color == Colors.blue) { 
          incrementSize = 100;
        } else if (state.color == Colors.black) {
          // 이전 앱에서는 새로운 state를 emit 했지만, _MyHomePageState에서는 emit 함수에 직접 접근이 불가능하므로 changeCounter 함수를 호출해야 한다.
          context.read<CounterCubit>().changeCounter(-100);
          incrementSize = -100;
        }
      },
      child: Scaffold(
        backgroundColor: context.watch<ColorCubit>().state.color,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text(
                  'Change Color',
                  style: TextStyle(fontSize: 24.0),
                ),
                onPressed: () {
                  context.read<ColorCubit>().changeColor();
                },
              ),
              SizedBox(height: 20.0),
              Text(
                '${context.watch<CounterCubit>().state.counter}',
                style: TextStyle(
                    fontSize: 52.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(
                  'Increment Counter',
                  style: TextStyle(fontSize: 24.0),
                ),
                onPressed: () {
                  context.read<CounterCubit>().changeCounter(incrementSize);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
