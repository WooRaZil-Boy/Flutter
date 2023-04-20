import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/questions_screen.dart';
import 'package:adv_basics/result_screen.dart';
import 'package:adv_basics/start_screen.dart';
import 'package:flutter/material.dart';

// 상태를 관리해야 하기 때문에 StatefulWidget을 사용해야 한다.
class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

// 밑줄을 사용하면, 해당 파일 안에서만 private 하다.
class _QuizState extends State<Quiz> {
  // 어떤 화면이 현재 보이는 지를 관리하기 때문에 결과 화면을 보여주는 곳이기도 해야 한다.
  // 또한, 선택한 답변을 저장하기 위한 곳이기도 하다. 질문과 답변을 선택한 곳에서 접근할 수 있기 때문이다.
  // QuestionScreen과 ResultsScreen 모두에서 Quiz를 사용한다.
  // 사용자가 답변한 목록을 관리한다. 처음엔 빈 리스트이지만, 사용자가 답변을 선택하면 답변이 추가된다.
  // 또한, 내부의 요소들이 추가될 뿐 변수 자체를 재할당 하는 것은 아니므로 final을 사용할 수 있다.
  // 하지만, 아예 빈 리스트로 재할당하려면 var로 써야 한다.
  List<String> _selectedAnswers = [];

  // 위젯도 객체일 뿐이므로 할당할 수 있다.
  // 타입을 Widget으로 명시해 줘야 다른 Widget 타입을 할당할 수 있다. var로 선언하면 해당 위젯 타입이 추론 된다.
  // 트리거하는 버튼이 한 위젯에 있고, 그 영향을 받아야 하는 또 다른 위젯이 있다.
  // 즉, 두 개의 위젯이 같은 상태로 동작해야 하거나 같은 상태에 의존한다.

  // 여기서는 함수를 넘겨서 이를 구현한다. 함수를 실행하는 게 아니라 포인터로 넘겨주게 된다. 함수도 객체일 뿐이다.
  // initState()는 객체 생성 직후 호출되고, 엄밀하게 객체 생성 중에 호출되는 것이 아니다.
  // 따라서 initState()에서 초기화 하더라도, 처음에는 값이 없으므로 Widget? 타입으로 선언해야 한다.
  // Widget? activeScreen;

  // Widget 대신 문자열과 삼항 연산자를 사용할 수도 있다. 이를 사용하면, initState()에서 초기화를 할 필요가 없다.
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      // activeScreen = const QuestionsScreen();
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    // 메모리에 있는 리스트 객체에 접근하여 아에팀을 추가한다. 변수를 재할당하는 것이 아니라 메모리에 있는 기존 리스트를 수정하는 것이기 때문에 final을 사용할 수 있다.
    _selectedAnswers.add(answer);

    // 선택한 답변을 저장하므로, 질문이 다 떨어졌는지 알 수 있다.
    if (_selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  // Widget activeScreen = const StartScreen(switchScreen); 처럼 바로 switchScreen를 넘겨줄 수 없다.
  // 기본적으로 변수 초기화와 메서드 생성은 객체 생성시에 발생하는데,
  // switchScreen은 생성자가 아닌 다른 메서드에서 생성되기 때문에 초기화가 아직 되어 있지 않기 때문이다.
  // 해결하는 방법인 여러 가지 있지만, 가장 쉬운 방법 중 하나는 initState()에서 초기화를 해주는 것이다.
  // initState()에서 초기화 로직을 재정의할 수 있다. 여기서 초기화를 하면, 생성자에서 초기화하는 것과 같은 효과를 얻을 수 있다.
  // initState()는 단 한 번만 호출되며, 다시 호출되지 않는다.
  // @override
  // void initState() {
  //   // build 메서드가 실행되기 전에 initState()가 먼저 실행되므로, 여기서는 setState()로 감쌀 필요가 없다.
  //   activeScreen = StartScreen(switchScreen);
  //   // 부모 클래스에서도 초기화 해야 하므로, super.initState()를 호출해야 한다.
  //   super.initState();
  // }

  void restartQuiz() {
    setState(() {
      _selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    // 이 변수는 build 메서드 내에서만 사용 가능하다.
    // 삼항 연산자와 문자열을 사용하도록 할 수 있다.
    // final screenWidget = activeScreen == 'start-screen'
    //         ? StartScreen(switchScreen)
    //         : const QuestionsScreen();

    // if 문을 사용하도록 수정할 수도 있다. 다양한 접근법을 알고 있어야 한다.
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'questions-screen') {
      // 현재까지 선택한 답변을 QuestionsScreen에 전달한다.
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

    // 모든 질문에 답하여, activeScreen이 'results-screen'이 되면, ResultsScreen을 보여준다.
    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: _selectedAnswers,
        onRestart: restartQuiz,
      );
    }

    return MaterialApp(
      // Scaffold를 custom Widet에 포함할 수도 있다.
      home: Scaffold(
        // Gradeint를 추가하기 위해 Container로 감싼다.
        body: Container(
            decoration: const BoxDecoration(
              // gradient를 추가했지만, 하위의 StartScreen 위젯 크기 만큼 적용된다.
              // 따라서 전체 화면에 적용하고 싶다면 StartScreen 크기를 조정해 줘야 한다.
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                // List는 Generic으로 타입을 지정해 줄 수 있다.
                colors: [
                  Color.fromARGB(255, 78, 13, 151),
                  Color.fromARGB(255, 107, 15, 168),
                ],
              ),
            ),
            // child: activeScreen,
            // screenWidget에 저장된 값이 child 인수에 값으로 전달된다.
            child: screenWidget),
      ),
    );
  }
}
