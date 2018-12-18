import "package:flutter/material.dart";
import 'package:meta/meta.dart';

import "unit.dart";

class Category { //이전에는 StatelessWidget를 상속한 Widget이었지만, 지금은 그냥 class 객체가 된다.
  final String name;
  final ColorSwatch color; //Material 디자인에 사용할 수 있는 색상 //Dictionary처럼 key로 해당 color를 저장해 놓을 수 있다.
  final List<Unit> units;
  final String iconLocation; //IconData는 Material 디자인에 사용할 수 있는 아이콘 데이터
  //Asset에서 가져오는 것으로 수정. String이 된다.

  const Category({ 
    @required this.name,
    @required this.color,
    @required this.units,
    @required this.iconLocation,
  })  : assert(name != null), 
        assert(color != null),
        assert(units != null),
        assert(iconLocation != null);
        //제약조건




  // //Navigation
  // void _navigateToConverter(BuildContext context) {
  //   Navigator.of(context).push(MaterialPageRoute<Null> ( //네비게이터에서 push 한다.
  //     builder: (BuildContext context) {
  //       return Scaffold(
  //         appBar: AppBar(
  //           elevation: 1.0,
  //           title: Text(
  //             name,
  //             style: Theme.of(context).textTheme.display1,
  //           ),
  //           centerTitle: true,
  //           backgroundColor: color,
  //         ),
  //         body: ConverterRoute(
  //           color: color,
  //           name: name,
  //           units: units,
  //         ),

  //         resizeToAvoidBottomPadding: false, //키보드가 호출될 때, 스크린이 resize되는 것을 막는다.
  //       );
  //     }
  //   ));
  // }

  // @override
  // Widget build(BuildContext context) { //build 함수를 재 정의해서 Widget을 생성한다.
  //   return Material(
  //     color: Colors.transparent,
  //     child: Container(
  //       height: _rowHeight,
  //       child: InkWell( //선택 시 잉크가 채워지는 효과
  //         borderRadius: _borderRadius,
  //         highlightColor: color['highlight'], //ColorSwatch에서 가져올 수 있다.
  //         splashColor: color['splash'], //ColorSwatch에서 가져올 수 있다.
  //         onTap: () => _navigateToConverter(context), //탭 제스처 시
  //         //함수가 한 줄인 경우 () => function() 혹은 () { function(); } 로 줄여 쓸 수 있다.
  //         child: Padding(
  //           padding: EdgeInsets.all(8.0),
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.stretch,
  //             //Flex에서 축에 따른 정렬을 지정한다(enum). 
  //             //baseline, center, end, start, stretch(축을 채운다), values(상수)
  //             children: [
  //               Padding(
  //                 padding: EdgeInsets.all(16.0),
  //                 child: Icon( //아이콘 생성
  //                   iconLocation,
  //                   size: 60.0,
  //                 ),
  //               ),
  //               Center(
  //                 child: Text(
  //                   name, //String
  //                   textAlign: TextAlign.center, //텍스트 수평 정렬(enum)
  //                   //center, end, justify, left, right, start, values
  //                   style: Theme.of(context).textTheme.headline, //테마를 적용한다.
  //                   //색상과 폰트를 선택할 수 있다.
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}