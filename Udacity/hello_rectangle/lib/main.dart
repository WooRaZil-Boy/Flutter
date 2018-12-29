import "package:flutter/material.dart";

//import "package:flutter/material.dart" show Container; 
//위와 같이 사용해 x패키지의 특정한 부분만 가져올 수도 있다.
//하지만 전체 패키지를 가져오더라도, Flutter가 사용하는 부분만 알아서 최적화하므로 큰 의미는 없다.

import "category_route.dart";

void main() {
  // runApp( //package:flutter/material.dart 를 import 해 오면 사용 가능해 진다.
  //   //인자로 어떤 Widget이라도 받아올 수 있다.
  //   MaterialApp( //Material 디자인의 다수 Widget을 래핑한다.
  //     debugShowCheckedModeBanner: false, //디버그 모드
  //     title: "Hello Rectangle",
  //     home: Scaffold( //home은 Navigator.defaultRouteName
  //       //Scaffold는 snackbar, persistent bottom sheet, AppBar 등을 담을 수 있는 위젯
  //       appBar: AppBar( //상단 바를 생성
  //         title: Text("Hello Rectangle"),
  //       ),
  //       body: HelloRectangle(), //클래스로 생성
  //     ),
  //   )
  // );

  runApp(UnitConverterApp());
}





// Widget helloRectangle() { //Widget이 반환형. 인자가 없는 함수
//   return Container(
//     color: Colors.greenAccent,
//   );
// }

//위의 함수를 Stateless class로 바꿔서 아래와 같이 만들어 줄 수 있다.

// class HelloRectangle extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) { //생성자를 오버라이딩 한다.
//     return Center(
//       child: Container(
//         padding: _padding,
//         color: Colors.greenAccent,
//         height: 400.0,
//         width: 300.0,
//         child: Center(
//           child: Text(
//             "Hello!",
//             style: TextStyle(fontSize: 40.0),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );

//     // return container;
//   }

//   var container = Container(
//     color: Colors.purple,
//     width: 300.0,
//     height: 400.0,
//     margin: EdgeInsets.all(16.0),
//     child: Column(
//       children: <Widget>[
//         Text("Hello!"),
//         Text("Hello!"),
//         Text("Hello!"),
//         Text("Hello!"),
//       ],
//     ),
//   );
// }

//Flutter에서 모든 것이 Widget이다. Widget에는 StatelessWidget과 StatefulWidget이 있다.
//StatelessWidget : immutable. 생성될 때 설정된 값이 변하지 않는다.
//StatefulWidget : state를 가지고 있는 Widget

//Container는 HTML의 <div>와 같다고 생각하면 된다.
//많은 Widget들은 child 혹은 children 프로퍼티를 가지고 있다.
//child : 오직 하나의 자식을 추가한다. Padding 등에 사용
//children : 다수의 자식을 추가한다. Colum, ListView, Stack 등에 사용




//Android Studio 에서는 Flutter Inspector를 이용할 수 있다. View - Flutter Inspector
//Chrome의 개발자 모드와 비슷하며, Widget들의 레이아웃과 정보를 쉽게 확인하고 디버그할 수 있다.
//Code - Reformat Code with dartfmt를 선택하면, 코드를 자동으로 정렬해 준다.

//Android Studio에서 해당 Widget에 커서가 있는 상태에서 alt + Enter를 해서 다른 Widget으로 래핑할 수 있다.




class UnitConverterApp extends StatelessWidget {
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: "Unit Converter",
  //     home: Scaffold(
  //       backgroundColor: Colors.green[100],
  //       body: Center(
  //         child: Category(
  //           name: _categoryName,
  //           color: _categoryColor,
  //           iconLocation: _categoryIcon,
  //         ),
  //       ),
  //     ),
  //   );
  // }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Unit Converter",
      theme: ThemeData( //테마 위젯을 구성한다.
        fontFamily: "Raleway", //전체 폰트 설정
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.grey[600],
        ),
        primaryColor: Colors.grey[500],
        textSelectionHandleColor: Colors.green[500],
      ),
      home: CategoryRoute(),
    );
  }
}

//Route는 Page나 Screen으로 생각하면 된다.
//Navigation도 Widget이다. push와 pop으로, child widget들을 이동시킬 수 있다.


//StatefullWidget은 Widget의 라이프 사이클 동안 변할 수 있는 state를 가지고 있다.




//패키지가 업데이트 되면(pubspec.yaml의 내용이 수정된 후), Terminal에서 flutter packages get을 입력하면 자동으로 업데이트 한다.




//asset은 따로 폴더 내에서 관리해 주는 것이 좋다. 이후, pubspec.yaml의 assets에서 해당 파일들의 경로를 입력해 주면 된다.
//아이콘이나 이미지도 같은 식으로 asset에 넣어주고, Image로 가져오면 된다.

//폰트는 asset과 같은 식으로 해서 pubspec.yaml의 fonts 항목에 넣어주면 된다. Fontfamily로 가져온다.
