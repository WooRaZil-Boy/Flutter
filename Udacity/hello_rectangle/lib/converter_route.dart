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
  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    //toStringAsPrecision은 double로 변환해서, 해당 숫자만큼 유효 숫자가 있는 문자열을 반환한다. 범위는 1 ~ 21

    if (outputNum.contains(".") && outputNum.endsWith("0")) { //.을 포함하고, 0으로 끝나면
      var i = outputNum.length - 1;
      while (outputNum[i] == "0") {
        i -= 1;
      }

      outputNum = outputNum.substring(0, i + 1); //0 ~ i+1 까지 자른다.
    }

    if (outputNum.endsWith(".")) { //. 으로 끝나면
      return outputNum.substring(0, outputNum.length - 1); //0 ~ outputNum.length - 1 까지 자른다.
    }

    return outputNum;
  }

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




//ColorSwatch : Dic 처럼 색상을 key로 저장해 놓을 수 있다. 색상 견본으로 볼 수 있다.
//TextField에서 keyboardType을 설정해 줄 수 있다. InputDecoration으로 placeholder를 지정해 줄 수 있다.
//Retrieving Text : 
//  onChanged(TextField에서 문자가 바뀔 때마다 호출)
//  onSubmitted(키보드에서 return이나 enter 키 누를 경우 호출)
//  controller(autocomplete 등에 사용) 
//텍스트를 입력할 때는 유효성 검사를 하는 것이 중요한데, errorText 프로퍼티로 설정해 줄 수 있다.




//unit_converter로 코드 내용 이전한다.