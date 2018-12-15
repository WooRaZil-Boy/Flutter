import "package:flutter/material.dart";
import 'package:meta/meta.dart';
import "unit.dart";

class ConverterRoute extends StatefulWidget {
  final String name;
  final Color color;
  final List<Unit> units;

  const ConverterRoute({ //제약조건
    @required this.name,
    @required this.color,
    @required this.units,
  })  : assert(name != null),
        assert(color != null),
        assert(units != null);

  @override
  _ConverterRouteState createState() => _ConverterRouteState();
  //StatefulWidget은 StatefulWidget를 구현해 state를 가져올 수 있어야 한다.
}

class _ConverterRouteState extends State<ConverterRoute> {
  @override
  Widget build(BuildContext context) {
    final unitWidgets = widget.units.map((Unit unit) { //Swift에서 클로저로 변수 생성하듯이
    //State에서 widget을 가져온다.
      return Container(
        color: widget.color,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              unit.name,
              style: Theme.of(context).textTheme.headline,
            ),
            Text(
              "Conversion: ${unit.conversion}",
              style: Theme.of(context).textTheme.subhead,
            )
          ],
        ),
      );
    }).toList(); //List로 변환. iterable 된다.

    return ListView( //위에서 생성한 위젯 리스트를 자식들로 해서 반환
      children: unitWidgets,
    );
  }
}

//ConverterRoute를 StatefulWidget으로 변경한다. StatefulWidget은 반드시 State를 설정해 줘야 한다.