import 'package:flutter/material.dart';

// 앱의 진입 페이지로 auth가 완료 되었으면 HomePage로, 완료되지 않았다면 SigninPage로 이동한다.
class SplashPage extends StatelessWidget {
  static const String routeName = '/';
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
