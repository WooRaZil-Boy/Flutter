import 'package:adv_basics/questions_summary/questions_identifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.itemData, {super.key});

  final Map<String, Object> itemData;

  @override
  Widget build(BuildContext context) {
    final isCorrectAnswer =
        itemData['user_answer'] == itemData['correct_answer'];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionIdentifier(
          // Map의 타입이 <String, Object>이므로, Object를 int로 변환해 사용해야 한다.
          questionIndex: itemData['question_index'] as int,
          isCorrectAnswer: isCorrectAnswer,
        ),
        const SizedBox(width: 20),
        // Row와 Colum을 사용하여 레이아웃을 구성하는 경우가 많다.
        // Expanded를 사용하면, Row나 Column의 자식들이 사용 가능한 모든 공간을 차지한다.
        // 기본적으로 Expanded를 사용하지 않으면, Row는 무한한 너비를 가지게 된다.
        // Expanded를는 하위 아이템이 flex 주축에 따라 사용 가능한 공간을 갖도록 한다.
        // flex는 그냥 Row 또는 Column 위젯 자체를 나타낸다.
        // Row는 기본적으로 너비가 무한이지만, 자식들이 있으면 자식들의 크기를 기준으로 너비를 결정한다.
        // 따라서 Expanded을 사용하여 폭을 제한할 수 있다.
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
              const SizedBox(height: 5),
              Text(
                itemData['user_answer'] as String,
                style: const TextStyle(
                  color: Color.fromARGB(255, 202, 171, 252),
                ),
              ),
              Text(
                itemData['correct_answer'] as String,
                style: const TextStyle(
                  color: Color.fromARGB(255, 181, 254, 246),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
