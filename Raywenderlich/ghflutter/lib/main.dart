import 'package:flutter/material.dart'; //material 패키지 가져오기 //material 디자인 패키지
import 'package:http/http.dart' as http; //HTTP 네트워크를 호출하는 패키지

import 'ghflutter.dart';
import "strings.dart"; //stirngs 파일 import

void main() => runApp(new GHFlutterApp()); //=> 은 Single line function으로 앱을 실행한다.
//Flutter는 main 함수에서 앱이 시작된다. //GHFlutterApp 클래스(Widget)를 생성해 반환한다.
//runApp()으로 해당 위젯을 screen에 불러온다.

// void main() {
//   return runApp(new GHFlutterApp());
// }
//위의 => 로 표현된 함수는 이 코드를 줄여 쓴 것이다.

class GHFlutterApp extends StatelessWidget { //앱의 클래스(Widget)
//StatelessWidget는 상태가 변하지 않는 Widget이다. 
//다른 기능 없이 화면의 UI를 구성하는 다른 Widget을 포함하고만 있으므로 Stateless이다.
  // @override
  // Widget build(BuildContext context) { //모든 Custom Widget은 객체를 반환하는 build 함수를 가지고 있다.
  //   return new MaterialApp( //Material 디자인의 App
  //     title: Strings.appTitle, //import한 String class에서 title을 가져 온다.
  //     home: new Scaffold( //비계. AppBar 혹은 Drawer과 같은 표준 앱 요소를 제공한다. 
  //       appBar: new AppBar( //AppBar는 상단의 Bar를 나타낸다.
  //         title: new Text(Strings.appTitle),
  //       ),
  //       body: new Center( //Center는 child를 중심으로 정렬시킨다.
  //         child: new Text(Strings.appTitle), //자식으로 Text Widget 추가
  //         //Text Widget은 Container Widget이 아니다.
  //         ),
  //     ),
  //     //MaterialApp Widget은 Scaffold로 Material 디자인을 쉽게 추가해 줄 수 있다.
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: Strings.appTitle,
      theme: new ThemeData(primaryColor: Colors.green.shade800), //테마 설정. 색상
      home: new GHFlutter(),
    );
  }
  //하드 코딩으로 구현한 위의 build()를 대체해, GHFlutter class(Widget)를 생성하는 것으로 재정의한다.
}

//Getting Started
//Flutter 프로젝트를 생성하면, ios, android 폴더와 main.dart가 포함된 lib 폴더가 생성된다.
//lib의 코드는 ios와 android에 모두 적용된다. lib 폴더의 코드만으로도 두 플랫폼에 모두 적용되는 앱을 작성할 수 있다.

//Debug> Start Debugging(F5)을 선택해 빌드할 수 있다. 시뮬레이터로 iOS와 Android가 모두 지원된다.
//Android는 Gradle을 사용해 시뮬레이터를 빌드하고, iOS는 Xcode의 시뮬레이터를 사용한다.




//Hot Reload
//Android Studio의 Instance Run과 비슷하게 실시간으로 변경사항을 확인해 볼 수 있다. Android, iOS에 모두 적용된다.




//Importing a File
//다른 파일을 import 해 와서 사용할 수 있다. 이는 Localizing에서 유용하게 사용된다.




//Widgets
//Flutter 앱의 모든 것이 Widget이다. Text, Button, Screen, Layout 모두 Widget이다. 빈 화면에 Widget을 추가해 나가면서 개발한다.
//Widget은 UI를 경량으로 유지하기 위해 immutable로 설계되었다.
//위젯은 계층적인 구조를 가지는데, 다른 위젯을 가질 수 있는 위젯을 Container Widget이라 한다(대부분의 위젯).
//Text Widget같이 아주 한정적인 작업을 하는 Widget들은 Container Widget이 아니다.

//Widget은 state에 반응 여부에 따라 StatelessWidget, StatefulWidget 으로 나눌 수 있다.
//• Stateless : image view의 image처럼, 자신의 정보에만 의존하는 Widget
//• Stateful : 다른 객체와 상호작용하여 동적인 정보를 유지해야하는 Widget
//StatelessWidget, StatefulWidget 모두 매 프레임마다 Flutter에서 다시 그려진다.
//차이점은 StatefulWidget이 설정을 State 객체에 위임한다.




//Cleaning the Code
//코드를 나눠서 리펙토링하고 깔끔하게 유지한다.





//Dart 2
//Dart 2는 strong compile-time checks를 추가했다.
//객체를 생성할 때 new 키워드를 사용하지 않아도 된다.
//현재는 Flutter와 Dart2가 완벽하게 호환되지 않는다.








