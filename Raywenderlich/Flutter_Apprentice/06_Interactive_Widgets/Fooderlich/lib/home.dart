import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/models.dart';

import 'screens/explore_screen.dart';
import 'screens/recipes_screen.dart';
import 'screens/grocery_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  static List<Widget> pages = <Widget>[
    ExploreScreen(),
    RecipesScreen(),
    const GroceryScreen()
  ];

  @override
  Widget build(BuildContext context) {
    // 모든 위젯을 Consumer 안에 래핑합니다. TabManager가 변경되면 그 아래의 위젯이 다시 빌드됩니다.
    return Consumer<TabManager>(builder: (context, tabManager, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Fooderlich',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        // 현재 탭 인덱스에 따라 올바른 페이지 위젯을 표시합니다.
        // IndexedStack을 사용하면 앱에서 위젯을 쉽게 전환할 수 있습니다.
        // 한 번에 하나의 하위 위젯만 표시하지만 모든 하위 위젯의 상태는 유지됩니다.
        body: IndexedStack(
          index: tabManager.selectedTab,
          children: pages
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
          // BottomNavigationBar의 현재 인덱스를 설정합니다.
          currentIndex: tabManager.selectedTab,
          onTap: (index) {
            // 사용자가 다른 탭을 탭할 때 manager.goToTab()을 호출하여 다른 위젯에 인덱스가 변경되었음을 알립니다.
            tabManager.goToTab(index);
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
    });
  }
}
