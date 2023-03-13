import 'package:flutter/material.dart';

import '../models/models.dart';
import 'components.dart';

class FriendPostListView extends StatelessWidget {
  const FriendPostListView({
    super.key,
    required this.friendPosts,
  });

  final List<Post> friendPosts;

  @override
  Widget build(BuildContext context) {
    // 왼쪽과 오른쪽에 16포인트의 패딩 위젯을 적용합니다.
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 0
      ),
      // Column을 만들어 Text와 그 뒤에 오는 글을 세로 레이아웃으로 배치합니다.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Social Chefs 👩‍🍳',
            style: Theme.of(context).textTheme.headline1
          ),
          // 세로로 16포인트의 간격을 적용합니다.
          const SizedBox(height: 16),
          // 두 개로 나눠진 ListView를 만드렁야 하므로 ListView.separated으로 생성합니다.
          ListView.separated(
            // 두 개의 목록 뷰를 중첩하고 있으므로 primary을 false로 설정하는 것이 좋습니다.
            // 이렇게 하면 Flutter가 이것이 기본 스크롤 뷰가 아님을 알 수 있습니다.
            primary: false,
            // primary을 false로 설정하더라도 이 목록 보기의 스크롤을 비활성화하는 것이 좋습니다.
            // 그러면 상위 목록 보기까지 전파됩니다.
            physics: const NeverScrollableScrollPhysics(),
            // fixed-length 스크롤 가능한 항목 목록을 만들려면 shrinkWrap을 true로 설정합니다.
            // 이렇게 하면 높이가 고정됩니다. 이 값이 false이면 높이가 제한되지 않는 오류가 발생합니다.
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: friendPosts.length,
            itemBuilder: (context, index) {
              final post = friendPosts[index];
              return FriendPostTile(post: post);
            },
            separatorBuilder: (context, index) {
              // 모든 항목에 대해 각 항목의 간격을 16포인트씩 띄우는 SizedBox를 만듭니다.
              return const SizedBox(height: 16);
            }
          )
          // 목록 끝에 약간의 패딩을 남겨둡니다.
        ],
      ),
    );
  }
}
