import "package:flutter/material.dart";
import "category.dart";
import "category_route.dart";

const _padding = EdgeInsets.all(16.0); //underscore는 provate임을 알려준다.
const _categoryName = 'Cake';
const _categoryIcon = Icons.cake;
const _categoryColor = Colors.green;
//const는 컴파일 타임에 결정되는 상수. 사용되지 않더라도 메모리 공간을 차지하게 된다.
//final은 런타임에 결정되는 상수. 한 번만 값을 설정할 수 있으며 액세스 될 때 초기화 되어 메모리 공간을 차지하게 된다(lazy).

//Icons은 미리 정의되어 사용할 수 있는 아이콘 데이터들이 있다. 그중 cake를 가져온다.
//https://docs.flutter.io/flutter/material/Icons-class.html


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

Widget helloRectangle() { //Widget이 반환형. 인자가 없는 함수
  return Container(
    color: Colors.greenAccent,
  );
}

//위의 함수를 Stateless class로 바꿔서 아래와 같이 만들어 줄 수 있다.

class HelloRectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) { //생성자를 오버라이딩 한다.
    return Center(
      child: Container(
        padding: _padding,
        color: Colors.greenAccent,
        height: 400.0,
        width: 300.0,
        child: Center(
          child: Text(
            "Hello!",
            style: TextStyle(fontSize: 40.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    // return container;
  }

  var container = Container(
    color: Colors.purple,
    width: 300.0,
    height: 400.0,
    margin: EdgeInsets.all(16.0),
    child: Column(
      children: <Widget>[
        Text("Hello!"),
        Text("Hello!"),
        Text("Hello!"),
        Text("Hello!"),
      ],
    ),
  );
  //Flutter에서 모든 것이 Widget이다. Widget에는 StatelessWidget과 StatefulWidget이 있다.
  //StatelessWidget : immutable. 생성될 때 설정된 값이 변하지 않는다.
  //StatefulWidget : state를 가지고 있는 Widget

  //Container는 HTML의 <div>와 같다고 생각하면 된다.
  //많은 Widget들은 child 혹은 children 프로퍼티를 가지고 있다.
  //child : 오직 하나의 자식을 추가한다. Padding 등에 사용
  //children : 다수의 자식을 추가한다. Colum, ListView, Stack 등에 사용
}

//Android Studio 에서는 Flutter Inspector를 이용할 수 있다. View - Flutter Inspector
//Chrome의 개발자 모드와 비슷하며, Widget들의 레이아웃과 정보를 쉽게 확인하고 디버그할 수 있다.
//Code - Reformat Code with dartfmt를 선택하면, 코드를 자동으로 정렬해 준다.

//Android Studio에서 해당 Widget에 커서가 있는 상태에서 alt + Enter를 해서 다른 Widget으로 래핑할 수 있다.




class UnitConverterApp extends StatelessWidget {
  @override
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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Unit Converter",
      home: CategoryRoute(),
    );
  }
}

//Route는 Page나 Screen으로 생각하면 된다.
//Navigation도 Widget이다. push와 pop으로, child widget들을 이동시킬 수 있다.


//StatefullWidget은 Widget의 라이프 사이클 동안 변할 수 있는 state를 가지고 있다.




