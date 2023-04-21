import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:adv_basics/questions_summary/question_identifier.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.itemData, {super.key});

  final Map<String, Object> itemData;

  @override
  Widget build(BuildContext context) {
    final isCorrectAnswer =
        itemData['user_answer'] == itemData['correct_answer'];

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionIdentifier(
            isCorrectAnswer: isCorrectAnswer,
            // 오류가 발생한 부분으로, int 형은 question이 아닌 question_index이다.
            // 개발중 IDE에서는 특정 형식의 정보를 저장하지 않으므로 오류가 발생하지 않는다.
            // 하지만 런타임에 실제로 코드가 실행되면 오류가 발생한다.
            questionIndex: itemData['question_index'] as int,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemData['question'] as String,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(itemData['user_answer'] as String,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 202, 171, 252),
                    )),
                Text(itemData['correct_answer'] as String,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 181, 254, 246),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 앱 내 표 되는 오류 메시지는 개발 중에만 확인할 수 있다. 실제 배포된 앱에서는 크래시가 발생한다.
// 좀 더  자세한 오류 메시지를 확인하려면 Debug console을 확인하면 된다.
// 어떤 위젯이 오류를 발생시켰는지, 해당 파일의 링크도 얻을 수 있다.
// Stack Trace의 첫 번째줄을 확인하면 오류를 발생시킨 코드나 진입점을 파악하는데 도움이 된다.