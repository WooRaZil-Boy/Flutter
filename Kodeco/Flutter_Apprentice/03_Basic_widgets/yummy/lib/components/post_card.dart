import 'package:flutter/material.dart';
import '../models/post.dart';

class PostCard extends StatelessWidget {
  // Post 객체를 받아 나중에 UI에 데이터를 표시하는 데 사용한다.
  final Post post;

  const PostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.apply(
          displayColor: Theme.of(context).colorScheme.onSurface,
        );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CircleAvatar는 주로 프로필 이미지나 사용자 아바타를 원형으로 표시하는 데 사용된다.
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(post.profileImageUrl),
            ),
            // 16px 간격을 추가한다.
            const SizedBox(
              width: 16,
            ),
            // 'Expanded' 위젯은 자식이 사용 가능한 모든 공간을 차지하도록 한다.
            Expanded(
              // 'Column' 위젯은 자식들을 수직으로 쌓는다. 
              child: Column(
                // 'MainAxisSize.min'은 자식들이 최소한의 공간을 차지하도록 정렬한다. 
                mainAxisSize: MainAxisSize.min,
                // 'CrossAxisAlignment.start'는 자식 위젯들을 왼쪽 수평으로 정렬한다.
                crossAxisAlignment: CrossAxisAlignment.start,
                // 두 개의 'Text' 위젯을 표시한다.
                children: [
                  // 게시물 내용
                  Text(
                    post.comment,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium,
                  ),
                  // 게시물의 타임스탬프
                  Text(
                    '${post.timestamp} mins ago',
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}