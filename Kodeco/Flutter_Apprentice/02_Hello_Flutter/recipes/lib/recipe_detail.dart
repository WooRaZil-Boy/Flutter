import 'package:flutter/material.dart';
import 'recipe.dart';

// 상태가 변경되므로 StatefulWidget이다.
class RecipeDetail extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetail({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  State<RecipeDetail> createState() {
    return _RecipeDetailState();
  }
}

class _RecipeDetailState extends State<RecipeDetail> {
  int _sliderVal = 1;

  @override
  Widget build(BuildContext context) {
    // Scaffold는 페이지의 일반적인 구조를 정의한다.
    // AppBar를 포함하는 Scaffold가 있으므로 Flutter는 자동으로 뒤로가기 버튼을 포함한다.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.label),
      ),
      // 노치, 하단의 홈 표시기 등 대화형 영역과 같은 운영 체제 인터페이스 공간을 피하기 위한 SafeArea를 추가한다.
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Image를 SizedBox로 감싼다.
            // 여기서 height는 300으로 고정되어 있지만 width는 가로 세로 비율에 맞게 조정된다.
            // Flutter의 단위는 logical pixels이다.
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image(
                image: AssetImage(widget.recipe.imageUrl),
              ),
            ),
            // 스페이서로 사용되는 SizedBox
            const SizedBox(height: 4),
            // style을 사용하여 텍스트의 모양을 변경할 수 있다.
            Text(
              widget.recipe.label,
              style: const TextStyle(fontSize: 18),
            ),
            // Column의 공간을 채우기 위해 확장되는 Expanded 위젯을 추가힌다.
            // 이렇게 하면 다른 위젯이 채우지 않은 공간을 재료 목록이 차지한다.
            Expanded(
              // ingredient당 하나의 행이 있는 ListView이다.
              child: ListView.builder(
                padding: const EdgeInsets.all(7.0),
                itemCount: widget.recipe.ingredients.length,
                itemBuilder: (BuildContext context, int index) {
                  final ingredient = widget.recipe.ingredients[index];
                  // string interpolation을 사용하여 문자열을 런타임 값으로 Text에 채운다.
                  return Text(
                      '${ingredient.quantity * _sliderVal} '
                      '${ingredient.measure} '
                      '${ingredient.name}'
                  );
                }
              )
            ),
            Slider(
              // min, max 및 divisions을 사용하여 슬라이더의 이동 방식을 정의한다.
              // 이 경우 슬라이더는 1에서 10 사이의 값 사이를 이동하며 10개의 멈춤점이 있다.
              // 즉, 1, 2, 3, 4, 5, 6, 7, 8, 9 또는 10의 값만 가질 수 있다.
              min: 1,
              max: 10,
              divisions: 9,
              // _sliderVal이 변경되면 label이 업데이트되어 서빙 횟수를 환산하여 표시한다.
              label: '${_sliderVal * widget.recipe.servings} servings',
              // 슬라이더는 double 값으로 작동하므로 int 변수를 변환해야 한다.
              value: _sliderVal.toDouble(),
              // 반대로 슬라이더가 변경되면 round()를 사용하여 double 값을 int로 변환하여 _sliderVal에 저장한다.
              onChanged: (newValue) {
                setState(() {
                  _sliderVal = newValue.round();
                });
              },
              // activeColor는 최소값과 현재값 사이의 섹션을 나타낸다.
              // inactiveColor는 나머지 섹션을 나타낸다.
              activeColor: Colors.green,
              inactiveColor: Colors.black,
            ),
          ],
        )
      ),
    );
  }
}

// Hot reload는 상태를 업데이트 한 이후 UI는 업데이트 하지 않으므로, Hot restart를 사용하여 앱을 다시 시작해야 할 때도 있다.