import 'package:flutter/material.dart';

class QuestionIdentifier extends StatelessWidget {
  final questionIndex;
  final isCorrectAnswer;

  const QuestionIdentifier({
    super.key,
    required this.questionIndex,
    required this.isCorrectAnswer,
  });

  @override
  Widget build(BuildContext context) {
    // index는 0부터 시작하므로 +1을 해줘야 한다.
    final questionNumber = questionIndex + 1;

    // SizedBox를 사용하면, decoration을 직접 사용할 수 없다.
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // isCorrectAnswer에 따라 색상이 달라진다.
        color: isCorrectAnswer 
          ? const Color.fromARGB(255, 150, 198, 241) 
          : const Color.fromARGB(255, 249, 133, 241),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        questionNumber.toString(),
        style: const TextStyle(
          color: Color.fromARGB(255, 22, 2, 56),
          fontWeight: FontWeight.bold,
        )
      ),
    );
  }
}