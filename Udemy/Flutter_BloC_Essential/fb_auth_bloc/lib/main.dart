import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
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
}



// 보통은 firebase console에서 프로젝트를 생성하고, iOS, Android 각각 만들어 추가해야 했다.
// 또한 Xcode, Android Studio에도 파일을 각각 추가해야 했다.
// flutter는 크로스 플랫폼인데 firebase 설정은 크로스 플랫폼이 아니었다.
// 이를 개선하기 위해 flutterfire_cli 를 공식적으로 지원하고 추천하는 방법이 되었다.
// 먼저 firebase cli 를 설치해야 한다. $ firebase —version 으로 제대로 설치되어 있는지 확인한다.
// https://firebase.google.com/docs/cli 를 참고하여 설치한다.
// 이후 flutterfire_cli를 global하게 설치하기 위해 다음 명령어를 입력한다.
// $ dart pub global activate flutterfire_cli
// https://stackoverflow.com/questions/71487625/how-can-i-resolve-zsh-command-not-found-flutterfire-in-macos
// 이후 vsc 해당 폴터 터미널에서 flutter pub add fitebase_core를 입력한다.
// 그러면 pubspec.yaml 에 firebase_core의 dependency가 설정된다.
// iOS 설정을 위해서는 iOS 폴더의 Podfile의 설정을 바꿔야 한다. platform 주석을 해제한다.
// 계속해서 flutter pub add firebase_auth 와 flutter pub add cloud_firestore 를 입력해 설치한다.
// 그러면 pubspec.yaml 에 firebase_auth 와 cloud_firestore의 dependency가 설정된다.
// 프로젝트 연결을 위해 계정을 연결해야 한다. 터미널에서 firebase login:list를 입력한다.
// 연결되어 있지 않으면 firebase login 를 입력해 계정을 연결한다.
// 연결이 되었다면 flutterfire configure 를 입력하여 셋업을 시작한다.
// 플랫폼을 설정하면 된다. 체크는 스페이스 선택은 엔터로 처리한다.
// 모든 설정이 정상적으로 완료되었으면, lib 폴더 아래에 firebase_options.dart 파일이 생성된다.
// https://firebase.flutter.dev/를 참고하여 설정이 제대로 완료되었는지 확인하고 코드를 붙여넣는다.
// 각각 android, ios 기기를 실행해 보면서 오류가 발생하면 수정해야 한다. android는 최소 SDK 버전, iOS는 pod 업데이트가 자주 발생한다.
// iOS의 경우 빌드 타임이 굉장히 길 수 있는데, firestore 때문인데, 이를 수정하기 위해 추가적인 설정이 필요할 수 있다.
// https://github.com/invertase/firestore-ios-sdk-frameworks