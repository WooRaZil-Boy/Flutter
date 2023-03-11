import 'package:flutter/material.dart';
import 'author_card.dart';
import 'fooderlich_theme.dart';

class Card2 extends StatelessWidget {
  const Card2({super.key});

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
            image: AssetImage('assets/mag5.png'),
            fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0)
          )
        ),
        child: Column(
          children: [
            const AuthorCard(
              authorName: 'Mike Katz',
              title: 'Smoothie Connoisseur',
              imageProvider: AssetImage('assets/author_katz.jpeg')
            ),
            // Expanded을 사용하면 남은 사용 가능한 공간을 채웁니다.
            Expanded(
              // Stack 위젯을 적용하여 텍스트를 서로 위에 배치합니다.
              child: Stack(
                children: [
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Text(
                      'Recipe',
                      style: FooderlichTheme.lightTextTheme.headline1
                    )
                  ),
                  Positioned(
                    bottom: 70,
                    left: 16,
                    child: RotatedBox(
                      // 시계 방향으로 1/4씩, 3번 회전합니다.
                      quarterTurns: 3,
                      child: Text(
                        'Smoothies',
                        style: FooderlichTheme.lightTextTheme.headline1
                      ),
                    )
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}

