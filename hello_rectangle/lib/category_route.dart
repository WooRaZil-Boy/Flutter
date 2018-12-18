import 'dart:async';
import 'dart:convert';

import "package:flutter/material.dart";

import "api.dart";
import "backdrop.dart";
import "category.dart";
import 'category_tile.dart';
import "unit.dart";
import 'unit_converter.dart';

class CategoryRoute extends StatefulWidget {
  const CategoryRoute();

  @override
  _CategoryRouteState createState() => _CategoryRouteState();
  //StatefulWidget은 StatefulWidget를 구현해 state를 가져올 수 있어야 한다.
}

class _CategoryRouteState extends State<CategoryRoute> {
  Category _defaultCategory;
  Category _currentCategory;
  final _categories = <Category>[]; //빈 카테고리 클래스 리스트

  static const _baseColors = <ColorSwatch>[
    ColorSwatch(0xFF6AB7A8, {
      'highlight': Color(0xFF6AB7A8),
      'splash': Color(0xFF0ABC9B),
    }),
    ColorSwatch(0xFFFFD28E, {
      'highlight': Color(0xFFFFD28E),
      'splash': Color(0xFFFFA41C),
    }),
    ColorSwatch(0xFFFFB7DE, {
      'highlight': Color(0xFFFFB7DE),
      'splash': Color(0xFFF94CBF),
    }),
    ColorSwatch(0xFF8899A8, {
      'highlight': Color(0xFF8899A8),
      'splash': Color(0xFFA9CAE8),
    }),
    ColorSwatch(0xFFEAD37E, {
      'highlight': Color(0xFFEAD37E),
      'splash': Color(0xFFFFE070),
    }),
    ColorSwatch(0xFF81A56F, {
      'highlight': Color(0xFF81A56F),
      'splash': Color(0xFF7CC159),
    }),
    ColorSwatch(0xFFD7C0E2, {
      'highlight': Color(0xFFD7C0E2),
      'splash': Color(0xFFCA90E5),
    }),
    ColorSwatch(0xFFCE9A9A, {
      'highlight': Color(0xFFCE9A9A),
      'splash': Color(0xFFF94D56),
      'error': Color(0xFF912D2D),
    }),
  ]; //ColorSwatch : Dic 처럼 색상을 key로 저장해 놓을 수 있다. 색상 견본으로 볼 수 있다.

  static const _icons = <String>[ //Assets
    'assets/icons/length.png',
    'assets/icons/area.png',
    'assets/icons/volume.png',
    'assets/icons/mass.png',
    'assets/icons/time.png',
    'assets/icons/digital_storage.png',
    'assets/icons/power.png',
    'assets/icons/currency.png',
  ];

  @override
  void didChangeDependencies() async { //dependency가 변경되면 호출된다.
    super.didChangeDependencies();

    if (_categories.isEmpty) {
      await _retrieveLocalCategories(); //async와 await는 묶어서 쓰인다.
      await _retrieveApiCategory();
    }
  }

  Future<void> _retrieveLocalCategories() async {
    final json = DefaultAssetBundle //기본 asset을 결정해 준다.
        .of(context)
        .loadString("assets/data/regular_units.json");
    final data = JsonDecoder().convert(await json); //JSON parsing

    if (data is! Map) { //Map type이 아니라면 오류 발생
      throw ("Data retrieved from API is not a Map");
    }

    var categoryIndex = 0;
    data.keys.forEach((key) {
      final List<Unit> units = 
        data[key].map<Unit>((dynamic data) => Unit.fromJson(data)).toList();

        var category = Category(
          name: key,
          units: units,
          color: _baseColors[categoryIndex],
          iconLocation: _icons[categoryIndex],
        );

        setState(() {
          if (categoryIndex == 0) {
            _defaultCategory = category;
          }
          _categories.add(category);
        });

        categoryIndex += 1;
    });
  }

  Future<void> _retrieveApiCategory() async { //API로 값을 가져온다.
    setState(() {
      _categories.add(Category(
        name: apiCategory["name"],
        units: [],
        color: _baseColors.last,
        iconLocation: _icons.last,
      ));
    });

    final api = Api();
    final jsonUnits = await api.getUnits(apiCategory["route"]);

    if (jsonUnits != null) {
      final units = <Unit>[];
      for (var unit in jsonUnits) {
        units.add(Unit.fromJson(unit));
      }
      
      setState(() {
        _categories.removeLast();
        _categories.add(Category(
          name: apiCategory["name"],
          units: units,
          color: _baseColors.last,
          iconLocation: _icons.last,
        ));
      });
    }
  }

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  // @override
  // void initState() { //객체가 생성되어 트리에 삽입될 때 호출. 자신이 생성한 state 객체에 대해 한 번만 호출된다.
  //   super.initState();

  //   //build(BuildContext context) 에서 하던 초기화 작업을 여기로 옮긴다.
  //   for (var i=0; i<_categoryNames.length; i++) { //카테고리 클래스에 요소를 넣어준다.
  //     var category = Category(
  //       name: _categoryNames[i],
  //       color: _baseColors[i],
  //       iconLocation: Icons.cake,
  //       units: _retrieveUnitList(_categoryNames[i]),
  //     );

  //     if (i == 0) {
  //       _defaultCategory = category;
  //     }

  //     _categories.add(category);
  //   }
  // }

  // void _onCategoryTap(Category category) { //카테고리 탭 될 때 호출
  //   setState(() { //state를 변경 하면서 값도 변경해 준다. 
  //     //StatefulWidget은 수동으로 화면을 다시 로드하지 않고, setState를 호출해 다시 위젯을 다시 그린다(Swift draw 처럼).
  //     //즉, setState를 호출하면, 위젯은 build 함수를 재호출해 새로 그리면서 해당 클로저의 내용도 반영하게 된다.
  //     _currentCategory = category;
  //   });
  // }

  Widget _buildCategoryWidgets(Orientation deviceOrientation) { //카테고리 위젯 생성
    if (deviceOrientation == Orientation.portrait) { //Orientation으로 디바이스 방향을 알 수 있다(세로).
      return ListView.builder( //ListView는 UITableView //builder 메서드로 생성해 줄 수 있다.
        itemBuilder: (BuildContext context, int index) {
          var _category = _categories[index];

          return CategoryTile(
            category: _categories[index],
            onTap: _category.name == apiCategory["name"] && _category.units.isEmpty
                    ? null 
                    : _onCategoryTap, //삼항 연산자 //오류 처리
          );
        },
        //itemBuilder: (BuildContext context, int index) => _categories[index], 
        //함수가 한 줄로 끝날 때 이렇게 표현할 수 있다.
        itemCount: _categories.length, //row num
      );
    } else { //가로 //GridView는 ListView가 여러 개 있는 것으로 생각할 수 있다. UICollectionView
      return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3.0,
        children: _categories.map((Category c) {
          return CategoryTile(
            category: c,
            onTap: _onCategoryTap,
          );
        }).toList(),
      );
    }
  }

  // List<Unit> _retrieveUnitList(String categoryName) {
  //   return List.generate(10, (int i) { //리스트 생성 //0 ~ 9 까지 순차적으로 i로 들어간다.
  //     i += 1;
  //     return Unit(
  //       name: "$categoryName Unit $i",
  //       conversion: i.toDouble()
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (_categories.isEmpty) {
      return Center(
        child: Container(
          height: 180.0,
          width: 180.0,
          child: CircularProgressIndicator(),
        ),
      );
    }

    assert(debugCheckHasMediaQuery(context)); //debugCheckHasMediaQuery 있는 지 확인

    final listView = Padding(
      padding: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 48.0,
      ),
      child: _buildCategoryWidgets(MediaQuery.of(context).orientation),
      //MediaQuery는 스크린의 사이즈와 방향 등의 정보를 가져올 수 있다.
    );

    return Backdrop(
      currentCategory:
          _currentCategory == null ? _defaultCategory : _currentCategory,
      frontPanel: _currentCategory == null //삼항 연산자
          ? UnitConverter(category: _defaultCategory)
          : UnitConverter(category: _currentCategory),
      backPanel: listView,
      frontTitle: Text("Unit Converter"),
      backTitle: Text("Select a Category"),
    );

    // final appBar = AppBar(
    //   elevation: 0.0, //z index
    //   title: Text(
    //     "Unit Converter",
    //     style: TextStyle( //텍스트 스타일 지정
    //       color: Colors.black,
    //       fontSize: 30.0,
    //     ),
    //   ),
    //   centerTitle: true,
    //   backgroundColor: _backgroundColor,
    // );

    // return Scaffold(
    //   appBar: appBar,
    //   body: listView,
    // );
  }
}

//CategoryRoute를 StatefulWidget으로 변경한다. StatefulWidget은 반드시 State를 설정해 줘야 한다.




//TextField에서 keyboardType을 설정해 줄 수 있다. InputDecoration으로 placeholder를 지정해 줄 수 있다.
//Retrieving Text : 
//  onChanged(TextField에서 문자가 바뀔 때마다 호출)
//  onSubmitted(키보드에서 return이나 enter 키 누를 경우 호출)
//  controller(autocomplete 등에 사용) 
//텍스트를 입력할 때는 유효성 검사를 하는 것이 중요한데, errorText 프로퍼티로 설정해 줄 수 있다.




//Responsive Design을 구현하는 방법에는 세 가지가 있다. Media query, Orientation builder, layout builder
//MediaQuery는 스크린의 사이즈와 방향 등의 정보를 가져올 수 있다.
//OrientationBuilder는 부모 위젯의 방향에 의존하는 트리를 만든다. MediaQuery보다 코드를 좀 더 간결하게 유지할 수 있다.
//LayoutBuilder는 부모 위젯의 크기에 위존하는 트리를 만든다. MediaQuery와 달리 전체 앱이 아닌 특정한 한 위젯에만 적용할 수 있다.