import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/questions_summary/questions_summary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  // 선택한 답변들을 받는다.
  final List<String> chosenAnswers;
  final void Function() onRestart;

  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
  });

  // Map은 key와 value를 갖는 데이터 구조이다.
  // 다트는 모든 값이 Object 이므로, 모든 종류의 값을 허용한 것이다.
  // 입력값이나 매개 변수가 없는 메서드는 결국 다른 클래스 속성에 기반한 데이터를 생성하는 것이다.
  // 이런 경우에는 getter를 사용할 수도 있다.
  // getter는 메서드처럼 호출되지만, 속성처럼 사용할 수 있다.
  // List<Map<String, Object>> getSummaryData() {
  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>>  summary = [];

    // for 문은 초기값, 조건, 증감식을 표현한다.
    for(var i = 0; i < chosenAnswers.length; i++) {
      // Map을 생성하는데 {}를 사용한다. [] 연산자를 사용하여 값을 추가할 수 있다.
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        // 첫 번째가 답으로 설정되어 있다.
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    // 같은 함수를 반복 호출하지 않도록 변수에 저장한다.
    // final symmaryData = summaryData;
    final numTotalQuestions = questions.length;
    // where을 사용해 필터링을 할 수 있다. where은 map과 같이 원본 리스트를 변경하지 않고 새로운 리스트를 반환한다.
    // getter는 변수처럼 사용한다.
    // 익명 함수는 input을 받아 함수 본문에 즉시 값을 반환환다. 특히, where이나 map에서 사용하기 좋다.
    // final numCorrectQuestions = summaryData.where((data) {
    //   // Map의 타입이 <String, Object>이므로, Object를 String으로 변환해 사용해야 한다.
    //   // 반환값이 true인 경우에만 포함된다.
    //   return data['user_answer'] == data['correct_answer'];
    // }).length;
    final numCorrectQuestions = summaryData
      .where((data) => data['user_answer'] == data['correct_answer']).length;

    // Column의 너비는 기본적으로 사용 가능한 모든 공간을 차지한다.
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 동적으로 할당되는 값이 있으므로 const를 사용할 수 없다.
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 230, 200, 253),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            QuestionsSummary(summaryData),
            const SizedBox(height: 30),
            // icon이 있는 TextButton을 사용하려면, icon constructor를 사용하면 된다.
            TextButton.icon(
              onPressed: onRestart,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Restart Quiz!'),
            )
          ],
        ),
      ),
    );
  }
}
