import 'package:flutter/material.dart';
import '../models/food_category.dart';

class CategoryCard extends StatelessWidget {
  // FoodCategory 객체를 받아 나중에 UI에 데이터를 표시하는 데 사용한다.
  final FoodCategory category;

  CategoryCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Card(
      child: Column(
        // min은 하위 자식들의 모든 사이즈를 더한 높이이다.
        // max는 하위 자식들만이 아닌 남은 공간까지 모두 포함한 총 높이이다.
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              // ClipRRect 위젯은 자식 위젯을 둥글게 만든다.
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  // 상단에만 둥근 모서리만 적용한다.
                  top: Radius.circular(8.0),
                ),
                child: Image.asset(category.imageUrl),
              ),
              // Stack의 좌측 상단에 Text 위젯을 배치한다.
              Positioned(
                left: 16.0,
                top: 16.0,
                child: Text(
                  'Yummy',
                  style: textTheme.headlineLarge,
                ),
              ),
              // Stack의 우측 하단에 Text 위젯을 배치한다.
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: RotatedBox(
                  // 90도 회전한다.
                  quarterTurns: 1,
                  child: Text(
                    'Smoothies',
                    style: textTheme.headlineLarge,
                  ),
                ),
              ),
            ],
          ),
          // 각각에 맞는 style을 textTheme에서 가져와 적용한다.
          ListTile(
            title: Text(
              category.name,
              style: textTheme.titleSmall,
            ),
            subtitle: Text(
              '${category.numberOfRestaurants} places',
              style: textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
