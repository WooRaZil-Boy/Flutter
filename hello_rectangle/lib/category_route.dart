import "package:flutter/material.dart";
import "category.dart";
import "unit.dart";

final _backgroundColor = Colors.green[100];

class CategoryRoute extends StatefulWidget {
  const CategoryRoute();

  @override
  _CategoryRouteState createState() => _CategoryRouteState();
  //StatefulWidget은 StatefulWidget를 구현해 state를 가져올 수 있어야 한다.
}

class _CategoryRouteState extends State<CategoryRoute> {
  final _categories = <Category>[]; //빈 카테고리 클래스 리스트

  static const _categoryNames = <String>[
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
    'Energy',
    'Currency',
  ];

  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];

  @override
  void initState() { //객체가 생성되어 트리에 삽입될 때 호출. 자신이 생성한 state 객체에 대해 한 번만 호출된다.
    super.initState();

    //build(BuildContext context) 에서 하던 초기화 작업을 여기로 옮긴다.
    for (var i=0; i<_categoryNames.length; i++) { //카테고리 클래스에 요소를 넣어준다.
      _categories.add(Category(
        name: _categoryNames[i],
        color: _baseColors[i],
        iconLocation: Icons.cake,
        units: _retrieveUnitList(_categoryNames[i]),
      ));
    }
  }

  Widget _buildCategoryWidgets() { //카테고리 위젯 생성
    return ListView.builder( //ListView는 UITableView //builder 메서드로 생성해 줄 수 있다.
      itemBuilder: (BuildContext context, int index) => _categories[index], 
      //함수가 한 줄로 끝날 때 이렇게 표현할 수 있다.
      itemCount: _categories.length, //row num
    );
  }

  List<Unit> _retrieveUnitList(String categoryName) {
    return List.generate(10, (int i) { //리스트 생성 //0 ~ 9 까지 순차적으로 i로 들어간다.
      i += 1;
      return Unit(
        name: "$categoryName Unit $i",
        conversion: i.toDouble()
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final listView = Container(
      color: _backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: _buildCategoryWidgets(),
    );

    final appBar = AppBar(
      elevation: 0.0, //z index
      title: Text(
        "Unit Converter",
        style: TextStyle( //텍스트 스타일 지정
          color: Colors.black,
          fontSize: 30.0,
        ),
      ),
      centerTitle: true,
      backgroundColor: _backgroundColor,
    );

    return Scaffold(
      appBar: appBar,
      body: listView,
    );
  }
}

//CategoryRoute를 StatefulWidget으로 변경한다. StatefulWidget은 반드시 State를 설정해 줘야 한다.