import 'package:flutter/material.dart';
import 'package:shake_count_app/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '흔들기 카운트 앱'),
    );
  }
}

// 앱의 타이틀은 Flutter의 manifest 파일이 아니라, 각 android, iOS에서 설정해야 한다.

// 앱 아이콘은 https://www.appicon.co/ 에서 각 플랫폼 별 앱 아이콘을 만들 수 있다. 역시 각 플랫폼 별로 교체해줘야 한다.

// iOS, Android 위에서 Flutter가 동작하기 때문에 앱이 처음 실행될 때, Native Splash Screen을 대응하지 않으면 짧은 시간이지만 흰 화면이 잠깐 나타난다.
// iOS에서는 App store 리젝 사유가 되고, Android에서는 필수 아닌 권장사항이다.
// 각각 대응하는 것이 원칙이지만, native splash 라는 라이브러리를 사용할 수 있다.
// 라이브러리가 많이 추가된다고 해서 앱 용량이 커지지 않는다. 라이브러리는 코드만 추가되기 때문이다.
// 해당 라이브러리의 코드를 실제로 사용하게 되면 용량이 커질 수 있다.