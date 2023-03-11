import 'package:flutter/material.dart';
import 'recipe.dart';

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({
    Key? key,
    required this.recipe
  }) : super(key: key);

  final Recipe recipe;

  @override
  State<RecipeDetail> createState() {
    return _RecipeDetailState();
  }
}

class _RecipeDetailState extends State<RecipeDetail> {
  int _sliderVal = 1;

  @override
  Widget build(BuildContext context) {
    // Scaffold는 페이지의 일반적인 구조를 정의합니다.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.label),
      ),
      // SafeArea은 앱이 노치나 대부분의 iPhone의 대화형 영역과 같은
      // 운영 체제 인터페이스에 너무 가까이 가지 않도록 합니다.
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Image 주변의 SizedBox입니다.
            // 여기서는 height가 300으로 고정되어 있지만 width는 가로 세로 비율에 맞게 조정됩니다.
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image(
                image: AssetImage(widget.recipe.imageUrl),
              ),
            ),
            // 스페이서 SizedBox
            const SizedBox(height: 4),
            Text(
              widget.recipe.label,
              style: const TextStyle(fontSize: 18),
            ),
            // Column의 공간을 채우기 위해 확장되는 Expanded 위젯을 추가합니다.
            // 이렇게 하면 다른 위젯이 채우지 않은 공간을 재료 목록이 차지합니다.
            Expanded(
              // ingredient당 하나의 행이 있는 ListView입니다.
              child: ListView.builder(
                padding: const EdgeInsets.all(7.0),
                itemCount: widget.recipe.ingredients.length,
                itemBuilder: (BuildContext context, int index) {
                  final ingredient = widget.recipe.ingredients[index];
                  // string interpolation을 사용하여 문자열을 런타임 값으로 채우는 Text입니다.
                  return Text(
                      '${ingredient.quantity * _sliderVal} '
                      '${ingredient.measure} '
                      '${ingredient.name}'
                  );
                }
              )
            ),
            Slider(
              // min, max 및 divisions을 사용하여 슬라이더의 이동 방식을 정의합니다.
              // 이 경우 슬라이더는 1에서 10 사이의 값 사이를 이동하며 10개의 멈춤점이 있습니다.
              // 즉, 1, 2, 3, 4, 5, 6, 7, 8, 9 또는 10의 값만 가질 수 있습니다.
              min: 1,
              max: 10,
              divisions: 9,
              // _sliderVal이 변경되면 label이 업데이트되어 서빙 횟수를 환산하여 표시합니다.
              label: '${_sliderVal * widget.recipe.servings} servings',
              // 슬라이더는 double 값으로 작동하므로 int 변수가 변환됩니다.
              value: _sliderVal.toDouble(),
              // 반대로 슬라이더가 변경되면 round()를 사용하여 double 슬라이더 값을
              // int로 변환한 다음 _sliderVal에 저장합니다.
              onChanged: (newValue) {
                setState(() {
                  _sliderVal = newValue.round();
                });
              },
              activeColor: Colors.green,
              inactiveColor: Colors.black,
            ),
          ],
        )
      ),
    );
  }
}