import 'package:after_layout/after_layout.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/s_main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    // 일반적으로 initState에서 화면의 전환이나 화면의 데이터를 바꿔주는 작업을 하면 크래시가 발생할수 있다.
    // initState에서는 값만 변경을 해야지, 화면에 영향을 주도록 코딩하면 안 된다.
    // 따라서 이런 경우에는 AfterLayoutMixin을 사용해서 initState가 끝난 이후에 작업을 해야 한다.

    delay(() {
      // 단순히 push를 사용하면 히스토리가 남아, android에서는 백 버튼으로 다시 splash 화면으로 돌아갈수 있다.
      // clearAllAndPush를 사용해서 히스토리가 남지 않도록 push 한다.
      Nav.clearAllAndPush(const MainScreen());
    }, 1500.ms);
    // Duration(microseconds: 1500)와 동일하게 사용하도록 extension 추가

    // 다만, Native의 splash와 Flutter splash가 순차적으로 나오게 된다. 따라서 WidgetsFlutterBinding을 사용하는 것이 좋다(main.dart)
  }

  @override
  Widget build(BuildContext context) {
    // Placeholder로 먼저 설정해 두면, 실제 위젯을 넣기전의 영역을 확인할수 있다.
    return Center(
      child: Image.asset(
        'assets/image/splash/splash.png',
        width: 192,
        height: 192,
      ),
    );
  }
}

// splash를 설정했지만, 실행 이후에도 로그인 등에서 사용할 splash 화면이 필요하다.