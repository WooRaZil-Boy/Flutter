import 'package:adv_basics/answer_button.dart';
import 'package:adv_basics/data/questions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 상태를 관리해야 하기 때문에 StatefulWidget을 사용해야 한다.
class QuestionsScreen extends StatefulWidget {
  // {}를 사용하여 인수에 이름을 붙일 수 있으며, 좀 더 명확하게 사용할 수 있다.
  const QuestionsScreen({
    super.key,
    required this.onSelectAnswer,
  });

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  // Answer 버튼을 누르면 해당 변수가 달라져야 한다.
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    // 이전 quiz에서 선택한 답변을 넘겨 받았지만, Widget을 생성할 때 전달 받았을 뿐, state에 저장된 것이 아니다.
    // state에서 widget에 접근할 때는 widget을 사용한다.
    widget.onSelectAnswer(selectedAnswer);

    // build를 다시 실행해야 하므로 setState를 사용한다.
    setState(() {
      // 오른쪽이 먼저 실행되므로 currentQuestionIndex = currentQuestionIndex + 1 로 쓸 수 있다.
      // currentQuestionIndex = currentQuestionIndex + 1;
      // currentQuestionIndex += 1;
      // 오직 1만 증가시키는 데 사용한다. 2 이상씩은 증가할 수 없다.
      // 계속해서 인덱스가 증가하면, 리스트의 범위를 벗어나 오류가 발생하게 된다.
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // questions.dart에서 가져온 데이터를 사용한다.
    // 해당 데이터로 질문이 달라진다. 따라서 statefulWidget을 사용해야 한다.
    final currentQuestion = questions[currentQuestionIndex];

    // 꽉찬 화면을 위해 Container를 사용한다.
    return SizedBox(
      width: double.infinity,
      child: Container(
        // crossAxisAlignment가 최대치로 늘어났기 때문에 margin을 줘서 공간을 만들어 준다.
        margin: const EdgeInsets.all(40),
        child: Column(
          // mainAxisSize: MainAxisSize.min, // 주축인 수직에서 가장 작은 크기로 적용된다.
          mainAxisAlignment: MainAxisAlignment.center,
          // 주축의 반대방향으로 적용된다.
          // stretch를 사용하면 최대치로 늘어나게 된다.
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              // GoogleFont 라이브러리를 사용한다.
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 201, 153, 251),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // map을 사용하면, 리스트의 값을 다른 값으로 바꿀 수 있다.
            // 하지만 map을 사용하다고 해서 기존의 리스트가 바뀌는 것은 아니다.
            // 메모리에 새로운 리스트를 만들어서 반환한다.
            // 하지만, currentQuestion.answers는 문자열 배열이므로 map의 결과가 Widget이 아닌 List<Widget> 으로 맞지 않다.
            // 따라서 ...을 사용해 리스트를 펼친다.
            // 각각 AnswerButton를 따로 생생할 필요 없이 코드가 깔끔해 진다. 하드코딩 대신 동적으로 위젯이 생성된다.
            // suffle을 한 후 mapping을 한다. 로직은 달라지지 않는다.
            ...currentQuestion.shuffledAnswers.map((answer) {
              // 객체는 dart의 일반 적인 값일 뿐이다.
              return AnswerButton(
                answerText: answer,
                // onTap은 void Function() 타입이므로, answer을 전달하기 위해서는 익명함수로 바꿔야 한다.
                // map을 사용하기 때문에 각각의 button을 생성하고 있다. 각 질문에 대한 answer을 전달해야 한다.
                onTap: () {
                  // 익명 함수의 본문은 버튼이 생성됐을 때 실행되지 않고, 버튼이 눌렸을 때 실행된다.
                  // 따라서 해당 시점에서 질문이 호출되고 버튼을 누르면 답변이 전달된다.
                  // 함수를 타고 들어가면서 호출되어 결국은 답변을 기록하게 된다.
                  answerQuestion(answer);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
