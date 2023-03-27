import 'package:cubit_payload/theme/theme_cubit.dart';
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
    return BlocProvider<ThemeCubit>(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Cubit Payload',
            debugShowCheckedModeBanner: false,
            theme: state.appTheme == AppTheme.light
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
            // BloC에서 event를 add한것과 달리 cubit에서는 직접 함수를 호출한다.
            context.read<ThemeCubit>().changeTheme(randInt);
          },
        ),
      ),
    );
  }
}
