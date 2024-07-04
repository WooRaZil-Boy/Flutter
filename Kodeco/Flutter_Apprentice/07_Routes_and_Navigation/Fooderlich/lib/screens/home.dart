import 'package:flutter/material.dart';

import 'explore_screen.dart';
import 'grocery_screen.dart';
import 'recipes_screen.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.currentTab,
  });

  final int currentTab;

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  static List<Widget> pages = <Widget>[
    ExploreScreen(),
    RecipesScreen(),
    const GroceryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fooderlich',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          profileButton(widget.currentTab),
        ],
      ),
      body: IndexedStack(index: widget.currentTab, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        currentIndex: widget.currentTab,
        onTap: (index) {
          // 사용자가 선택한 현재 탭을 업데이트합니다.
          Provider.of<AppStateManager>(context, listen: false).goToTab(index);
          // GoRouter를 사용하여 선택한 탭으로 이동합니다.
          // 다른 경로로 이동하는 방법에는 두 가지가 있습니다:
          //  - 1. context.go(path)
          //  - 2. context.goNamed(name)
          // go는 오류가 발생하기 쉽고 시간이 지남에 따라 실제 URI 형식이 변경될 수 있으므로
          // go 대신 goNamed를 사용해야 합니다.
          // goNamed는 각 GoRoute에 설정한 name 매개변수를 사용하여 대소문자를 구분하지 않는 조회를 수행합니다.
          // 또한, 매개변수와 쿼리 매개변수를 경로에 전달할 때에도 goNamed를 사용할 수 있습니다.
          context.goNamed(
            'home',
            params: {
              'tab': '$index'
            }
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'To Buy',
          ),
        ],
      ),
    );
  }

  Widget profileButton(int currentTab) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(
            'assets/profile_pics/person_stef.jpeg',
          ),
        ),
        onTap: () {
          context.goNamed(
            'profile',
            params: {
              'tab': '$currentTab',
            }
          );
        },
      ),
    );
  }
}
