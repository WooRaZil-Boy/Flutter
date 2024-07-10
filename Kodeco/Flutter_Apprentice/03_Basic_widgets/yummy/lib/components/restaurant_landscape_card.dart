import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/restaurant.dart';

class RestaurantLandscapeCard extends StatelessWidget {
  // Restaurant 객체를 받아 나중에 UI에 데이터를 표시하는 데 사용한다.
  final Restaurant restaurant;

  const RestaurantLandscapeCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            // borderRadius를 8.0로 주어 상단 모서리를 둥글게 만든다.
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(8.0),
            ),
            // AspectRatio로 2:1의 가로 대 세로 비율로 이미지를 표시한다.
            child: AspectRatio(
              aspectRatio: 2,
              child: Image.asset(
                restaurant.imageUrl,
                // 이미지 크기는 컨테이너에 맞게 조정된다.
                fit: BoxFit.cover,
              ),
            ),
          ),
          // ListTile을 사용해 제목과 속성을 표시한다.
          ListTile(
            // 스타일에 맞춰 제목과 속성을 표시한다.
            title: Text(
              restaurant.name,
              style: textTheme.titleSmall,
            ),
            subtitle: Text(
              restaurant.attributes,
              // 두 줄 이상이면 자른다.
              maxLines: 1,
              style: textTheme.bodySmall,
            ),
            onTap: () {
              // 탭 하면 레스토랑 이름을 출력한다.
              print('Tap on ${restaurant.name}');
            },
          ),
        ],
      ),
    );
  }
}
