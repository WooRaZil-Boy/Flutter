import 'package:flutter/material.dart';

// 계속해서 반복되는 형식이 있다면 custom Widget으로 리팩토링 하는 것이 좋다.
// 관리해야 할 상태가 없기 때문에 StatelessWidget을 사용한다.
class AnswerButton extends StatelessWidget {
  final String answerText;
  // 콜백으로 사용할 함수도 전달 받아야 한다.
  final void Function() onTap;

  // 이름으로 인수를 받고 싶다면, 중괄호 안에 해당 변수를 넣어준다. required를 붙이지 안으면 옵셔널이 된다.
  // 중괄호 안에 변수를 넣어주면 해당 변수는 필수로 전달해야 하며, 순서는 중요하지 않다.
  const AnswerButton(
      {super.key, required this.answerText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      // custom Widget에서 style을 지정했기 때문에 관리가 편하고 코드양이 줄어든다.
      style: ElevatedButton.styleFrom(
        // 수평, 수직의 패딩이 서로 다른 경우, symmetric을 사용할 수 있다.
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 40,
        ),
        backgroundColor: const Color.fromARGB(255, 33, 1, 95),
        // 글자 색상
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      // answerText는 해당 위젯 외부에서 전달된 변수 이기 때문에 더이상 const를 사용할 수 없다.
      child: Text(answerText),
    );
  }
}
