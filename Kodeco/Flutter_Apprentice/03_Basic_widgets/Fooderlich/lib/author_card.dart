import 'package:flutter/material.dart';
import 'fooderlich_theme.dart';
import 'circle_image.dart';

// 작은 기기에서 앱을 실행하는 경우 AuthorCard 위젯에 경고가 표시될 수 있습니다.
// 이는 텍스트가 컨테이너를 넘기기 때문입니다.
// AuthorCard 위젯을 FittedBox 위젯으로 감싸면 이 문제를 해결할 수 있습니다.
class AuthorCard extends StatelessWidget {
  const AuthorCard({
    super.key,
    required this.authorName,
    required this.title,
    this.imageProvider,
  });

  final String authorName;
  final String title;
  final ImageProvider? imageProvider;

  // AuthorCard는 컨테이너에 그룹화되어 있으며 Row 위젯을 사용하여 다른 위젯을 가로로 배치합니다.
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        // Row의 자식 사이에 공간이 균등하게 추가되어 화면 맨 오른쪽에 IconButton이 배치됩니다.
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleImage(
                imageProvider: imageProvider,
                imageRadius: 28,
              ),
              // 이미지와 텍스트 사이에 8픽셀의 패딩을 적용합니다.
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authorName,
                    style: FooderlichTheme.lightTextTheme.headline2,
                  ),
                  Text(
                    title,
                    style: FooderlichTheme.lightTextTheme.headline3,
                  )
                ],
              )
            ],
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            iconSize: 30,
            color: Colors.grey[400],
            // 사용자가 아이콘을 누르면 snackbar를 표시합니다.
            onPressed: () {
              const snackBar = SnackBar(content: Text('Favorite Pressed'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }, 
          )
        ],
      ),
    );
  }
}
