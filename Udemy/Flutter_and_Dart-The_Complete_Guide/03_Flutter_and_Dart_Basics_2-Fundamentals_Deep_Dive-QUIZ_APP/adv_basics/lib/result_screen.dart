import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  // 선택한 답변들을 받는다.
  final List<String> chosenAnswers;

  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
  });

  @override
  Widget build(BuildContext context) {
    // Column의 너비는 기본적으로 사용 가능한 모든 공간을 차지한다.
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Results'),
            const SizedBox(height: 30),
            const Text('Results'),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {},
              child: const Text('Restart Quiz!'),
            )
          ],
        ),
      ),
    );
  }
}
