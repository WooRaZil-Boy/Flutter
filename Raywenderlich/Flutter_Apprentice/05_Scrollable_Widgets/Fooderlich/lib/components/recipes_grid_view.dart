import 'package:flutter/material.dart';

import '../components/components.dart';
import '../models/models.dart';

class RecipesGridView extends StatelessWidget {
  const RecipesGridView({
    super.key,
    required this.recipes,
  });

  final List<SimpleRecipe> recipes;

  @override
  Widget build(BuildContext context) {
    // 왼쪽, 오른쪽, 상단에 16포인트 패딩을 적용합니다.
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16
      ),
      // 화면에 표시되는 항목만 표시하는 GridView.builder를 만듭니다.
      child: GridView.builder(
        // 그리드 뷰에 그리드에 표시할 항목 수를 지정합니다.
        itemCount: recipes.length,
        // 열이 두 개만 있다는 뜻입니다.
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          // 6
          final simpleRecipe = recipes[index];
          return RecipeThumbnail(recipe: simpleRecipe);
        }
      ),
    );
  }
}
