import 'package:flutter/material.dart';

import '../models/models.dart';

class RecipeThumbnail extends StatelessWidget {
  const RecipeThumbnail({
    super.key,
    required this.recipe,
  });

  final SimpleRecipe recipe;

  @override
  Widget build(BuildContext context) {
    // 사방에 8포인트 패딩이 있는 Container를 생성합니다.
    return Container(
      padding: const EdgeInsets.all(8),
      // 세로 레이아웃을 적용하려면 Column을 사용합니다.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column의 첫 번째 요소는 Expanded이며, 이 위젯은 Image에 고정됩니다.
          // 이미지가 나머지 공간을 채웁니다.
          Expanded(
            // Image는 이미지를 클립하여 테두리를 둥글게 만드는 ClipRRect 안에 있습니다.
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                recipe.dishImage,
                fit: BoxFit.cover,
              ),
            )
          ),
          const SizedBox(height: 10),
          Text(
            recipe.title,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            recipe.duration,
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}
