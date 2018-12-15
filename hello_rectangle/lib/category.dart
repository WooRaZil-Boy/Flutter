import "package:flutter/material.dart";
import 'package:meta/meta.dart';
import "converter_route.dart";
import "unit.dart";

final _rowHeight = 100.0; //final은 상수. undersocre는 private
final _borderRadius = BorderRadius.circular(_rowHeight / 2);
//const는 컴파일 타임에 결정되는 상수. 사용되지 않더라도 메모리 공간을 차지하게 된다.
//final은 런타임에 결정되는 상수. 한 번만 값을 설정할 수 있으며 액세스 될 때 초기화 되어 메모리 공간을 차지하게 된다(lazy).

class Category extends StatelessWidget {
  final String name;
  final ColorSwatch color; //Material 디자인에 사용할 수 있는 색상
  final IconData iconLocation; //Material 디자인에 사용할 수 있는 아이콘 데이터
  final List<Unit> units;

  const Category({ 
    Key key,
    @required this.name,
    @required this.color,
    @required this.iconLocation,
    @required this.units,
  })  : assert(name != null), 
        assert(color != null),
        assert(iconLocation != null),
        assert(units != null),
        super(key: key);
        //제약조건

  //Navigation
  void _navigateToConverter(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<Null> ( //네비게이터에서 push 한다.
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            title: Text(
              name,
              style: Theme.of(context).textTheme.display1,
            ),
            centerTitle: true,
            backgroundColor: color,
          ),
          body: ConverterRoute(
            color: color,
            name: name,
            units: units,
          ),
        );
      }
    ));
  }

  @override
  Widget build(BuildContext context) { //build 함수를 재 정의해서 Widget을 생성한다.
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _rowHeight,
        child: InkWell( //선택 시 잉크가 채워지는 효과
          borderRadius: _borderRadius,
          highlightColor: color,
          splashColor: color,
          onTap: () => _navigateToConverter(context), //탭 제스처 시
          //함수가 한 줄인 경우 () => function() 혹은 () { function(); } 로 줄여 쓸 수 있다.
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              //Flex에서 축에 따른 정렬을 지정한다(enum). 
              //baseline, center, end, start, stretch(축을 채운다), values(상수)
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon( //아이콘 생성
                    iconLocation,
                    size: 60.0,
                  ),
                ),
                Center(
                  child: Text(
                    name, //String
                    textAlign: TextAlign.center, //텍스트 수평 정렬(enum)
                    //center, end, justify, left, right, start, values
                    style: Theme.of(context).textTheme.headline, //테마를 적용한다.
                    //색상과 폰트를 선택할 수 있다.
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}