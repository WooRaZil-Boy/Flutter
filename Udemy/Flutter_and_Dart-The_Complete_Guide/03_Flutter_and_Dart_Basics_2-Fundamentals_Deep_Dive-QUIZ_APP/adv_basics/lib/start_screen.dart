import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  // 생성자에도 const를 추가할 수 있다.
  // 인수와 반환값이 없는 함수를 인수로 받는다.
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  // Widget에는 build 메서드가 필수로 있어야 하고, context인수를 받아 Widget을 반환한다.
  @override
  Widget build(BuildContext context) {
    // 성능 최적화를 위해 const를 추가할 수 있다. 이를 추가하면, 메모리에 한 번만 저장되고 이 값을 재사용한다.
    // Center 위젯은 공간을 최대한 많이 확보한다. 여기서는 Scaffold의 body에 추가되어 있기 때문에 화면 전체를 차지한다.
    return Center(
      child: Column(
        // 최소한의 크기만 차지하도록 설정한다. 여기서는 주축이 vertical이기 때문에 수직으로 최소한의 크기만 차지한다.
        mainAxisSize: MainAxisSize.min,
        children: [
          // 이미지를 사용하기 위해서는 단순히 추가하는 것 뿐 아니라, pubspec.yaml에 경로를 설정해 줘야 한다.
          // Image Widget을 Opacity 위젯으로 감싸 투명도를 조절할 수도 있다.
          // 하지만 일반적으로 불투명도를 직접 수정하는 것은 권장하지 않는다.
          // 아래와 같이 Image 자체를 수정하는 것이 더 좋은 방법이다.
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
            color: const Color.fromARGB(150, 255, 255, 255),
          ),
          // 공간을 띄우기 위해 SizedBox를 사용할 수 있다.
          const SizedBox(height: 80),
          Text(
            'Learn Flutter the fun way!',
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 237, 223, 252),
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 30),
          // 아이콘이 추가된 버튼을 사용하려면, 단순히 생성자를 수정하면 된다.
          OutlinedButton.icon(
            // 인수로 받은 함수를 그대로 실행할 수 있다. tear-off
            onPressed: startQuiz,
            // 설정하는 버튼을 그대로 사용하여 styleFrom을 지정한다. 스타일을 좀 더 쉽게 적용할 수 있다.
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            // icon 인수는 Widget을 받을 수 있다. 따라서 Icon이 아닌 다른 Widget도 가능하다.
            // Icon은 Wdiget이므로, 여기서 뿐 아니라 일반 child 인수로도 사용할 수 있다.
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text('Start Quiz'),
          ),
        ],
      ),
    );
  }
}

// 다트는 객체 지향 언어로 모든 값이 객체이다.
// class는 청사진으로 어던 로직과 데이터가 있는지 알려준다.
// 이 객체들은 데이터 구성과 논리를 분리하는데 쓰인다.