import 'package:flutter/material.dart';

import '../components/components.dart';
import '../models/models.dart';
import '../api/mock_fooderlich_service.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  // 서버 응답 Mock 객체
  final mockService = MockFooderlichService();

  @override
  Widget build(BuildContext context) {
    // FutureBuilder는 비동기 작업을 실행하고 미래의 상태를 알려줍니다.
    return FutureBuilder(
      // FutureBuilder는 매개변수로 Future를 받습니다.
      future: mockService.getExploreData(),
      // builder 내에서 snapshot을 사용하여 Future의 현재 상태를 확인합니다.
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        // builder 콜백 내에서 Future의 상태를 확인합니다.
        // Future가 완료되었으며 위젯에 전달할 데이터를 추출할 수 있습니다.
        if (snapshot.connectionState == ConnectionState.done) {
          // 이 기본 ListView가 다른 두 ListView를 자식으로 보유합니다.
          return ListView(
            // 스크롤 방향을 세로로 설정하는 것이 기본값입니다.
            scrollDirection: Axis.vertical,
            children: [
              // todayRecipes를 추출하여 ListView로 전달합니다.
              TodayRecipeListView(recipes: snapshot.data?.todayRecipes ?? []),
              // item이 서로 너무 가깝지 않도록 16포인트 세로 공백을 추가합니다.
              const SizedBox(height: 16),
              // FriendPostListView를 만들고 ExploreData에서 friendPosts을 추출합니다.
              FriendPostListView(friendPosts: snapshot.data?.friendPosts ?? []),
            ],
          );
        } else {
          // 아직 로드 중이므로 사용자에게 무언가가 일어나고 있음을 알리기 위해 스피너를 표시합니다.
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}
