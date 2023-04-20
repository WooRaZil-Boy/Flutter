// 위젯이 너무 길어지면 따로 떼어내어 관리하는 것이 좋다.
import 'package:adv_basics/questions_summary/summary_item.dart';
import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  final List<Map<String, Object>> summaryData;

  const QuestionsSummary(this.summaryData, {super.key});

  @override
  Widget build(BuildContext context) {
    // 이전에는 SizedBox을 두 항목 사이에 빈 공간을 추가하는 데 사용했지만, 여기에서는 Column의 높이를 제한하기 위해 사용한다.
    // 해당 높이를 넘어서게 되면 잘리게 된다. 따라서, 스크롤이 되도록 SingleChildScrollView를 사용한다.
    return SizedBox(
      height: 400,
      // SingleChildScrollView는 하나의 child만 가질 수 있고, 그 child는 스크롤 할 수 있다.
      // 여기서는 위에서 설정한 SizedBox의 height를 넘어서게 되면 스크롤이 된다.
      child: SingleChildScrollView(
        child: Column(
          // map은 Iterable을 반환한다. List로 사용하기 위해서는 toList()로 변환해 줘야 한다.
          children: summaryData.map((data) {
            return SummaryItem(data);
          }).toList(),
        ),
      ),
    );
  }
}
