import 'package:bloc2bloc_observer81/bloc/color/color_bloc.dart';
import 'package:bloc2bloc_observer81/observer/app_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter/counter_bloc.dart';


void main() {
  // 앱에 사용되는 모든 BloC에 대해 observer를 지정한다.
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorBloc>(
          create: (context) => ColorBloc()
        ),
        BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(colorBloc: context.read<ColorBloc>()),
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ColorBloc>().state.color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text(
                'Change Color',
                style: TextStyle(fontSize: 24.0),
              ),
              onPressed: () {
                context.read<ColorBloc>().add(ChangeColorEvent());
              },
            ),
            const SizedBox(height: 20.0),
            Text(
              '${context.watch<CounterBloc>().state.counter}',
              style: const TextStyle(
                fontSize: 52.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text(
                'Increment Counter',
                style: TextStyle(fontSize: 24.0),
              ),
              onPressed: () {
                context.read<CounterBloc>().add(ChangeCounterEvent());
              },
            )
          ],
        ),
      ),
    );
  }
}