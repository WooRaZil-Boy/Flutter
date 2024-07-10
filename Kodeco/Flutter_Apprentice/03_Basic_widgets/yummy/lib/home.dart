import 'package:flutter/material.dart';
import 'components/theme_button.dart';
import 'components/color_button.dart';
import 'constants.dart';
import 'components/category_card.dart';
import 'models/food_category.dart';
import 'components/post_card.dart';
import 'models/post.dart';
import 'components/restaurant_landscape_card.dart';
import 'models/restaurant.dart';

// 앱이 커질 수록 Widget을 분리하는 것이 좋다. Main의 Scaffold를 Home으로 이동한다.
class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.changeTheme,
    required this.changeColor,
    required this.colorSelected,
  });

  final void Function(bool useLightMode) changeTheme;
  final void Function(int value) changeColor;
  final ColorSelection colorSelected;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tab = 0; // 현재 선택된 탭을 추적한다.
  // 각각의 탭으로 사용할 페이지를 정의한다.
  List<NavigationDestination> appBarDestinations = const [
    NavigationDestination(
      icon: Icon(Icons.credit_card),
      label: 'Category',
      selectedIcon: Icon(Icons.credit_card),
    ),
    NavigationDestination(
      icon: Icon(Icons.credit_card),
      label: 'Post',
      selectedIcon: Icon(Icons.credit_card),
    ),
    NavigationDestination(
      icon: Icon(Icons.credit_card),
      label: 'Restaurant',
      selectedIcon: Icon(Icons.credit_card),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      // 카드 Widget이 화면 중앙에 오도록 Center Widget을 사용한다.
      Center(
        child: ConstrainedBox(
          // 최대 너비 300px을 적용한다.
          constraints: const BoxConstraints(maxWidth: 300),
          // CategoryCard에 mock data를 전달한다.
          child: CategoryCard(
            category: categories[0],
          ),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PostCard(
            post: posts[0],
          ),
        ),
      ),
      // Center 위젯은 카드 위젯이 화면 중앙에 오도록 한다.
      Center(
        // ConstrainedBox으로 최대 너비를 400px로 제한한다.
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          // RestaurantLandscapeCard에 mock data를 전달한다.
          child: RestaurantLandscapeCard(
            restaurant: restaurants[0],
          ),
        ),
      )
    ];

    // Scaffold 'AppBar'와 body를 포함하는 앱의 시각적 구조를 정의한다.
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          ThemeButton(
            changeThemeMode: widget.changeTheme,
          ),
          ColorButton(
            changeColor: widget.changeColor,
            colorSelected: widget.colorSelected,
          ),
        ],
      ),
      body: IndexedStack(
        index: tab,
        children: pages,
      ),
      // bottomNavigationBar를 설정한다.
      bottomNavigationBar: NavigationBar(
        // selectedIndex는 선택된 tab을 지정한다.
        selectedIndex: tab,
        // 사용자가 탭을 선택하면, 활성시킬 tab을 업데이트한다.
        onDestinationSelected: (int index) {
          setState(() {
            tab = index;
          });
        },
        // tabs 목록을 지정한다.
        destinations: appBarDestinations,
      ),
    );
  }
}
