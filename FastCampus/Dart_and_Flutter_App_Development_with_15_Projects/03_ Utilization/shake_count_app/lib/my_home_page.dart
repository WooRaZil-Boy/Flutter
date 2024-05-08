import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  // with : mixin 형태로 구현한다.
  // implements : interface 형태로 구현한다(모두 구현해야 한다).
  int _counter = 0;
  late ShakeDetector detector; // nullalbe하게 구현할 수도 있다.

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        setState(() {
          _counter++;
        });
      },
      shakeThresholdGravity: 1.5,
    );

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // 이벤트 리스너 제거해서 메모리 누수를 방지한다.
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // build 함수에서 widget을 const 키워드로 사용하면, 컴파일 시간에 상수로 생성되어 계속 재사용되기 때문에 성능이 향상된다.
  // 반대로, const 키워드가 없는 widget은 계속해서 새로 생성된다.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '흔들어서 카운트를 올려보세요.',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 앱의 life cycle 변화를 감지한다. WidgetsBindingObserver를 구현해야 한다.
    switch (state) {
      case AppLifecycleState.resumed: // 일반 활성화 상태
        detector.startListening();
        break;
      case AppLifecycleState
            .inactive: // 재난 문자 알림, 전화 등으로 인해 화면에 노출되지만 유저의 입력을 받지 않을 때
        break;
      case AppLifecycleState.paused: // 백그라운드로 갈 때
        detector.stopListening();
        break;
      case AppLifecycleState.detached: // 종료
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }
}

// flutter ios, android, window 등에 상관없이 life cycle을 아래와 같이 정의한다.
//              화면에 노출              유저 Input 가능              OS View에 붙어있는가?
// inactive         O                       X                           O
// paused           X                       X                           O
// resumed          O                       O                           O
// detached         X                       X                           X