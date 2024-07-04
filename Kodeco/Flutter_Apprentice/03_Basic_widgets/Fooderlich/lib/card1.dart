import 'package:flutter/material.dart';
import 'fooderlich_theme.dart';

class Card1 extends StatelessWidget {
  const Card1({super.key});

  final String category = 'Editor\'s Choice';
  final String title = 'The Art of Dough';
  final String description = 'Learn to make the perfect bread.';
  final String chef = 'Ray Wenderlich';

  // 모든 StatelessWidget에는 override할 수 있는 build() 메서드가 있습니다.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // 모든 면에 16의 패딩을 적용합니다.
        // 플러터 단위는 logical pixels로 지정되며, 이는 Android의 dp와 같습니다.
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 450
        ),
        decoration: const BoxDecoration(
          // BoxDecoration에서 상자에 이미지를 그리도록 지시하는 DecorationImage를 설정합니다.
          image: DecorationImage(
            image: AssetImage('assets/mag1.png'),
            // 해당 이미지로 박스 전체를 덮습니다.
            fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        child: Stack(
          children: [
            Text(
              category,
              style: FooderlichTheme.darkTextTheme.bodyText1,
            ),
            // Positioned 위젯은 Stack에서 Text를 배치할 위치를 제어합니다.
            Positioned(
              top: 20,
              child: Text(
                title,
                style: FooderlichTheme.darkTextTheme.headline2,
              ),
            ),
            Positioned(
              bottom: 30,
              right: 0,
              child: Text(
                description,
                style: FooderlichTheme.darkTextTheme.bodyText1,
              ),
            ),
            Positioned(
              bottom: 10,
              right: 0,
              child: Text(
                chef,
                style: FooderlichTheme.darkTextTheme.bodyText1,
              )
            )
          ],
        ),
      ),
    );
  }
}
