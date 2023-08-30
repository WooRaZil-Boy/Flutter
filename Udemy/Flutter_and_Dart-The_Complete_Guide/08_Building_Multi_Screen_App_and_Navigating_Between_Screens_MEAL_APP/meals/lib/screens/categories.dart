import 'package:flutter/material.dart';

// 내부 상태를 관리할 필요가 없으므로 StatelessWidget을 사용한다.
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 다중 스크린 앱을 제작한다면, 기본적으로 Scaffold를 사용하는 것이 일반적이다.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      body: Center(
        // 일반적으로는 GridView.builder를 사용해 생성한다.
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            // 가로 축이 Row 2개로 설정된다.
            crossAxisCount: 2,
            // 가로 세로 비율을 3:2로 설정한다.
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: const [
            Text('1', style: TextStyle(color: Colors.white),),
            Text('2', style: TextStyle(color: Colors.white),),
            Text('3', style: TextStyle(color: Colors.white),),
            Text('4', style: TextStyle(color: Colors.white),),
            Text('5', style: TextStyle(color: Colors.white),),
            Text('6', style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
    );
  }
}