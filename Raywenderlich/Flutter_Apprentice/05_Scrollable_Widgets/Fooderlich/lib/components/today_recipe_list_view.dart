import 'package:flutter/material.dart';

import '../components/components.dart';
import '../models/models.dart';

class TodayRecipeListView extends StatelessWidget {
  const TodayRecipeListView({
    super.key,
    required this.recipes,
  });

  // 표시할 레시피 목록이 필요합니다.
  final List<ExploreRecipe> recipes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16
      ),
      // 세로 레이아웃에 위젯을 배치하기 위해 Column을 추가합니다.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text를 추가합니다. 이것이 Recipes of the Day의 헤더입니다.
          Text(
            'Recipes of the Day 🍳',
            style: Theme.of(context).textTheme.headline1
          ),
          // 패딩을 제공하기 위해 16포인트 높이의 SizedBox를 추가합니다.
          const SizedBox(height: 16),
          // 400포인트 높이의 Container를 추가하고 배경색을 grey으로 설정합니다.
          // 이 Container에 Row ListView가 들어갑니다.
          Container(
            height: 400,
            color: Colors.transparent,
            child: ListView.separated(
              // 스크롤 방향을 horizontal축으로 설정합니다.
              scrollDirection: Axis.horizontal,
              itemCount: recipes.length,
              // 항목을 처리합니다.
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return buildCard(recipe);
              },
              // 간격을 처리합니다.
              separatorBuilder: (context, index) {
                // 모든 item을 16포인트 간격으로 배치하는 SizedBox를 만듭니다.
                return const SizedBox(width: 16);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildCard(ExploreRecipe recipe) {
    if (recipe.cardType == RecipeCardType.card1) {
      return Card1(recipe: recipe);
    } else if (recipe.cardType == RecipeCardType.card2) {
      return Card2(recipe: recipe);
    } else if (recipe.cardType == RecipeCardType.card3) {
      return Card3(recipe: recipe);
    } else {
      throw Exception('This card doesn\'t exist yet');
    }
  }
}
