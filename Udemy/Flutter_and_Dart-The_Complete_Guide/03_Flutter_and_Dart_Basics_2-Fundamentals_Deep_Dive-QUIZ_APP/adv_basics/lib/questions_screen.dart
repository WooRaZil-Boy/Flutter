import 'package:adv_basics/answer_button.dart';
import 'package:adv_basics/data/questions.dart';
import 'package:flutter/material.dart';

// 상태를 관리해야 하기 때문에 StatefulWidget을 사용해야 한다.
class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    // questions.dart에서 가져온 데이터를 사용한다.
    final currentQuestion = questions[0];

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
              style: const TextStyle(
                color: Colors.white,
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
            ...currentQuestion.answers.map((answer) {
              // 객체는 dart의 일반 적인 값일 뿐이다.
              return AnswerButton(
                answerText: answer,
                onTap: () {},
              );
            }),
          ],
        ),
      ),
    );
  }
}
