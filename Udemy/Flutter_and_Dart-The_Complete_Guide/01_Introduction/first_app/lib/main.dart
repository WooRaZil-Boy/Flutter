
 

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// With Flutter, you create user interfaces by combining "widgets"
// You'll learn all about them (and much more) throughout this course!
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Every custom widget must have a build() method
  // It tells Flutter, which widgets make up your custom widget
  // Again: You'll learn all about that throughout the course!
  @override
  Widget build(BuildContext context) {
    // Below, a bunch of built-in widgets are used (provided by Flutter)
    // They will be explained in the next sections
    // In this course, you will, of course, not just use them a lot but
    // also learn about many other widgets!
    return MaterialApp(
      title: 'Flutter First App',
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Flutter - The Complete Guide Course',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Learn Flutter step-by-step, from the ground up.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// build 폴더는 실행에 관여하는 파일을 flutter가 자동으로 생성한다.
// 각 OS 별 폴더는 해당 OS에민 적용되는 특정 기능들을 구현할 때와 앱스토어 업로드 시에 사용한다. 일반적으로는 사용할 일이 거의 없다.
// metadata는 가동으로 관리된다. 삭제하거나 수정할 필요가 없다.
// analysis_options는 오류 노출에 관한 설정을 제어할 수 있다.
// pubspec에서는 라이브러리 종속성을 관리한다.

// 실제 실행은 Dart가 코드를 구분 분석하여 대상 플랫폼에서 이해할 수 있는 언어로 번역한다.
// Dart 자체로는 해당 플랫폼에서 실행할 수 없다. 따라서 구문 분석 후 다양한 Dart와 Flutter 툴로 컴파일된다.
// 이렇게 묶여진 코드 번들이 실제 플랫폼 장치에서 실행된다.