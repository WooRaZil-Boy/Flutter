import "dart:async";

import "package:flutter/material.dart";
import "package:meta/meta.dart";

import "api.dart";
import "category.dart";
import "unit.dart";

const _padding = EdgeInsets.all(16.0); //underscore는 provate임을 알려준다.
//const는 컴파일 타임에 결정되는 상수. 사용되지 않더라도 메모리 공간을 차지하게 된다.
//final은 런타임에 결정되는 상수. 한 번만 값을 설정할 수 있으며 액세스 될 때 초기화 되어 메모리 공간을 차지하게 된다(lazy).

//Icons은 미리 정의되어 사용할 수 있는 아이콘 데이터들이 있다. 그중 cake를 가져온다.
//https://docs.flutter.io/flutter/material/Icons-class.html

class UnitConverter extends StatefulWidget {
  final Category category;

  const UnitConverter({
    @required this.category,
  }) : assert(category != null); //제약 조건

  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  Unit _fromValue;
  Unit _toValue;
  double _inputValue;
  String _convertedValue = "";
  List<DropdownMenuItem> _unitMenuItems;
  bool _showValidationError = false;
  final _inputKey = GlobalKey(debugLabel: "inputText");
  bool _showErrorUI = false; //Error Handler

  @override
  void initState() { //객체가 생성되어 트리에 삽입될 때 호출. 자신이 생성한 state 객체에 대해 한 번만 호출된다.
    super.initState();
    _createDropdownMenuItems();
    _setDefaults();
  }

  @override
  void didUpdateWidget(UnitConverter old) { //widget이 업데이트될 대마다 호출된다.)
    super.didUpdateWidget(old);
    
    if (old.category != widget.category) {
      _createDropdownMenuItems();
      _setDefaults();
    }
  }

  void _createDropdownMenuItems() {
    var newItems = <DropdownMenuItem>[]; //드랍다운 메뉴

    for (var unit in widget.category.units) {
      newItems.add(DropdownMenuItem(
        value: unit.name,
        child: Container(
          child: Text(
            unit.name,
            softWrap: true,
          ),
        ),
      ));  
    }

    setState(() { //state를 변경 하면서 값도 변경해 준다. 
      //StatefulWidget은 수동으로 화면을 다시 로드하지 않고, setState를 호출해 다시 위젯을 다시 그린다(Swift draw 처럼).
      //즉, setState를 호출하면, 위젯은 build 함수를 재호출해 새로 그리면서 해당 클로저의 내용도 반영하게 된다.
      _unitMenuItems = newItems;
    });
  }

  void _setDefaults() {
    setState(() { //state를 변경 하면서 값도 변경해 준다. 
      //StatefulWidget은 수동으로 화면을 다시 로드하지 않고, setState를 호출해 다시 위젯을 다시 그린다(Swift draw 처럼).
      //즉, setState를 호출하면, 위젯은 build 함수를 재호출해 새로 그리면서 해당 클로저의 내용도 반영하게 된다.
      _fromValue = widget.category.units[0];
      _toValue = widget.category.units[1];  
    });

    if (_inputValue != null) {
      _updateConversion();
    }
  }

  String _format(double conversion) { //0을 제거해 준다. ex. 5.500 -> 5.5, 10.0 -> 10
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

  Future<void> _updateConversion() async {
    if (widget.category.name == apiCategory["name"]) { //API 사용하는 경우
      final api = Api();
      final conversion = await api.convert(apiCategory['route'],
          _inputValue.toString(), _fromValue.name, _toValue.name);

      if (conversion == null) { //오류 
        setState(() {
          _showErrorUI = true;
        });
      } else {
        setState(() {
          _convertedValue = _format(conversion);
        });
      }
    } else { //일반적인 경우
      setState(() { //state를 변경 하면서 값도 변경해 준다. 
        //StatefulWidget은 수동으로 화면을 다시 로드하지 않고, setState를 호출해 다시 위젯을 다시 그린다(Swift draw 처럼).
        //즉, setState를 호출하면, 위젯은 build 함수를 재호출해 새로 그리면서 해당 클로저의 내용도 반영하게 된다.
        _convertedValue =
            _format(_inputValue * (_toValue.conversion / _fromValue.conversion));
      });
    }
  }

  void _updateInputValue(String input) {
    setState(() { //state를 변경 하면서 값도 변경해 준다. 
      //StatefulWidget은 수동으로 화면을 다시 로드하지 않고, setState를 호출해 다시 위젯을 다시 그린다(Swift draw 처럼).
      //즉, setState를 호출하면, 위젯은 build 함수를 재호출해 새로 그리면서 해당 클로저의 내용도 반영하게 된다.
      if (input == null || input.isEmpty) {
        _convertedValue = "";
      } else {
        //'5...0', '6 -3' 등의 입력을 할 수 있기 때문에 Numerical keyboard를 설정해 두었어도 유효성 검사를 하는 것이 좋다.
        try {
          final inputDouble = double.parse(input);
          _showValidationError = false;
          _inputValue = inputDouble;
          _updateConversion();
        } on Exception catch (e) { //예외처리
          print("Error: $e"); //dart에서는 interpolation으로 $문자 를 사용
          _showValidationError = true;
        }
      }
    });
  }

  Unit _getUnit(String unitName) {
    return widget.category.units.firstWhere( //최초의 요소를 가져온다.
      (Unit unit) {
        return unit.name == unitName;
      },
      orElse: null, //값을 가져올 수 없을 때
    );
  }

  void _updateFromConversion(dynamic unitName) {
    setState(() {
      _fromValue = _getUnit(unitName);
    });

    if (_inputValue != null) {
      _updateConversion();
    }
  }

  void _updateToConversion(dynamic unitName) {
    setState(() {
      _toValue = _getUnit(unitName);
    });

    if (_inputValue != null) {
      _updateConversion();
    }
  }

  Widget _createDropdown(String currentValue, ValueChanged<dynamic> onChanged) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(
          color: Colors.grey[400],
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith( //복사본으로 가져온다
          canvasColor: Colors.grey[50],
        ),
        child: DropdownButtonHideUnderline( //밑줄이 없는 드랍다운 버튼
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: currentValue,
              items: _unitMenuItems,
              onChanged: onChanged,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.category.units == null ||
        (widget.category.name == apiCategory["name"] && _showErrorUI)) { //오류 처리
      return SingleChildScrollView(
        child: Container(
          margin: _padding,
          padding: _padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: widget.category.color["error"],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 180.0,
                color: Colors.white,
              ),
              Text(
                "Oh no! We can't connect right now!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    final input = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField( //Text를 input할 수 있는 Widget
            key: _inputKey,
            style: Theme.of(context).textTheme.display1,
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.display1,
              errorText: _showValidationError ? 'Invalid number entered' : null,
              labelText: "Input",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
            keyboardType: TextInputType.number,
            onChanged: _updateInputValue,
          ),
          _createDropdown(_fromValue.name, _updateFromConversion),
        ],
      ),
    );

    final arrows = RotatedBox(
      quarterTurns: 1, //회전 수. 1 = 90도
      child: Icon(
        Icons.compare_arrows,
        size: 40.0,
      ),
    );

    final output = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputDecorator(
            child: Text(
              _convertedValue,
              style: Theme.of(context).textTheme.display1,
            ),
            decoration: InputDecoration(
              labelText: "Output",
              labelStyle: Theme.of(context).textTheme.display1,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
          _createDropdown(_toValue.name, _updateToConversion),
        ],
      ),
    );

    final converter = ListView(
      children: [
        input,
        arrows,
        output,
      ],
    ); //각각의 객체를 만들어서 하나의 ListView에 담는다.

    return Padding(
      padding: _padding,
      child: OrientationBuilder( //상위 위젯의 방향에 의존되는 트리
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.portrait) { //세로
            return converter;
          } else { //가로
            return Center(
              child: Container(
                width: 450.0,
                child: converter,
              ),
            );
          }
        },
      ),
    ); //패딩된 Column을 반환(build 메서드)
  }
}