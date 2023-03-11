import 'dart:developer';
import 'package:flutter/material.dart';
import 'fooderlich_theme.dart';

class Card3 extends StatelessWidget {
  const Card3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 450
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/mag2.png'),
            fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                // 60% 반투명 배경의 색상 오버레이가 있는 컨테이너를 추가 합니다.
                color: Colors.black.withOpacity(0.6),
                borderRadius: const BorderRadius.all(Radius.circular(10.0))
              ),
            ),
            Container(
              // 모든 면에 16픽셀의 패딩을 적용합니다.
              padding: const EdgeInsets.all(16),
              child: Column(
                // 모든 위젯을 Column의 left에 배치합니다.
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.book,
                    color: Colors.white,
                    size: 40,
                  ),
                  // 8픽셀 공백을 적용합니다.
                  const SizedBox(height: 8),
                  Text(
                    'Recipe Trends',
                    style: FooderlichTheme.darkTextTheme.headline2
                  ),
                  // 30픽셀 공백을 적용합니다.
                  const SizedBox(height: 30)
                ],
              ),
            ),
            Center(
              // Wrap은 각 자식을 이전 자식에 인접하게 배치하려고 시도하는 레이아웃 위젯입니다.
              // 공간이 충분하지 않으면 다음 줄로 줄 바꿈합니다.
              child: Wrap(
                // 가능한 한 왼쪽, 즉 start 부분에 가깝게 자식을 배치합니다.
                alignment: WrapAlignment.start,
                // main axis의 각 자식 사이에 12픽셀 간격을 적용합니다.
                spacing: 12,
                // cross axis의 각 자식 사이에 12픽셀 간격을 적용합니다.
                runSpacing: 12,
                children: [
                  // Chip은 텍스트 및 이미지 아바타를 표시하고
                  // 탭 및 삭제와 같은 사용자 작업을 수행하는 디스플레이 요소입니다.
                  Chip(
                    label: Text(
                      'Healthy',
                      style: FooderlichTheme.darkTextTheme.bodyText1
                    ),
                    backgroundColor: Colors.black.withOpacity(0.7),
                    onDeleted: () {
                      log('delete');
                    },
                  ),
                  Chip(
                    label: Text(
                      'Vegan',
                      style: FooderlichTheme.darkTextTheme.bodyText1
                    ),
                    backgroundColor: Colors.black.withOpacity(0.7),
                    onDeleted: () {
                      log('delete');
                    },
                  ),
                  Chip(
                    label: Text(
                      'Carrots',
                      style: FooderlichTheme.darkTextTheme.bodyText1
                    ),
                    backgroundColor: Colors.black.withOpacity(0.7),
                  ),
                  Chip(
                    label: Text(
                      'Greens',
                      style: FooderlichTheme.darkTextTheme.bodyText1
                    ),
                    backgroundColor: Colors.black.withOpacity(0.7),
                  ),
                  Chip(
                    label: Text(
                      'Wheat',
                      style: FooderlichTheme.darkTextTheme.bodyText1
                    ),
                    backgroundColor: Colors.black.withOpacity(0.7),
                  ),
                  Chip(
                    label: Text(
                      'Pescetarian',
                      style: FooderlichTheme.darkTextTheme.bodyText1
                    ),
                    backgroundColor: Colors.black.withOpacity(0.7),
                  ),
                  Chip(
                    label: Text(
                      'Lemongrass',
                      style: FooderlichTheme.darkTextTheme.bodyText1
                    ),
                    backgroundColor: Colors.black.withOpacity(0.7),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
