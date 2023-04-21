import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:adv_basics/answer_button.dart';
import 'package:adv_basics/data/questions.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.onSelectAnswer,
  });

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    // currentQuestionIndex = currentQuestionIndex + 1;
    // currentQuestionIndex += 1;
    setState(() {
      currentQuestionIndex++; // increments the value by 1
    });
  }

  @override
  Widget build(context) {
    // debug 모드에서는 break point를 사용한수 있다. 단순히 cutter에서 클릭을 하면 빨간 점으로 표시된다.
    // break point를 사용하면 해당 코드가 실행되는 시점에서 앱이 멈추고, 현재 속성과 변수에 저장된 값을 확인할 수 있다.
    // 여기서는 questions과 currentQuestionIndex 모두 확인해 볼 수 있다. 
    // 해당 변수를 우클릭 add to watch를 선택하면 왼쪽 패널에 값이 추가되고, 해당 값이 변경될 때마다 자동으로 갱신된다.
    // 왼쪽 패널의 variables에서 전체 화면의 속성들을 살펴볼 수 있다.
    // 왼쪽 패널의 call stack에서 현재 실행되고 있는 함수들을 살펴볼 수 있다.
    // break point를 다시 클릭해 해제하고, 필요한 부분과 시점에서 다시 설정할 수 있다.
    // 여기서는 questions의 index를 6으로 찾으려 해서 오류가 발생한다.
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 201, 153, 251),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...currentQuestion.shuffledAnswers.map((answer) {
              return AnswerButton(
                answerText: answer,
                onTap: () {
                  answerQuestion(answer);
                },
              );
            })
          ],
        ),
      ),
    );
  }
}