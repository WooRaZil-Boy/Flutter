import 'package:flutter/material.dart';

import '../components/components.dart';
import '../models/models.dart';

class FriendPostTile extends StatelessWidget {
  const FriendPostTile({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    // Row은 위젯을 가로로 정렬합니다.
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleImage(
          imageProvider: AssetImage(post.profileImageUrl),
          imageRadius: 20,
        ),
        // 16포인트 패딩을 적용합니다.
        const SizedBox(width: 16),
        // Expanded을 생성하여 자식이 컨테이너의 나머지 부분을 채우도록 합니다.
        Expanded(
          // Column을 설정하여 위젯을 세로로 정렬합니다.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 친구의 댓글을 표시할 Text를 만듭니다.
              Text(post.comment),
              // 글의 타임스탬프를 표시할 다른 Text를 만듭니다.
              Text(
                '${post.timestamp} mins ago',
                style: const TextStyle(fontWeight: FontWeight.w700)
              ),
            ],
          )
        )
      ],
    );
  }
}
