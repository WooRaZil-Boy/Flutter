import 'package:adv_basics/start_screen.dart';
import 'package:flutter/material.dart';

// 상태를 관리해야 하기 때문에 StatefulWidget을 사용해야 한다.
class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Scaffold를 custom Widet에 포함할 수도 있다.
      home: Scaffold(
        // Gradeint를 추가하기 위해 Container로 감싼다.
        body: Container(
          decoration: const BoxDecoration(
            // gradient를 추가했지만, 하위의 StartScreen 위젯 크기 만큼 적용된다. 
            // 따라서 전체 화면에 적용하고 싶다면 StartScreen 크기를 조정해 줘야 한다.
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              // List는 Generic으로 타입을 지정해 줄 수 있다.
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
            ),
          ),
          child: const StartScreen(),
        ),
      ),
    );
  }
}