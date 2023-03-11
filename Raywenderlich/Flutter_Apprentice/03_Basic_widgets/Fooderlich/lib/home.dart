import 'package:flutter/material.dart';
import 'card1.dart';
import 'card2.dart';
import 'card3.dart';


// StatefulWidget을 확장합니다.
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  // _selectedIndex는 현재 어떤 탭이 선택되어 있는지 추적합니다.
  // _selectedIndex의 밑줄은 private임을 나타냅니다.
  // 선택된 인덱스는 _HomeState가 추적 중인 state입니다.
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    const Card1(),
    const Card2(),
    const Card3()
  ];

  // 여기서 사용자가 누른 항목의 인덱스를 설정합니다.
  // setState()는 이 객체의 상태가 변경되었음을 프레임워크에 알린 다음 내부적으로 이 위젯을 다시 빌드합니다.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fooderlich',
          // main 에서는 theme.textTheme.headline6를 썼지만,
          // 여기서는 Theme.of(context).textTheme.headline6 을 쓰고 있습니다.
          // Theme.of(context)는 위젯 트리에서 가장 가까운 Theme를 반환합니다.
          // 위젯에 정의된 Theme가 있는 경우 해당 테마를 반환합니다. 그렇지 않으면 앱의 테마를 반환합니다.
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // 탭했을 때 항목의 선택 색상을 설정합니다.
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        // currentIndex는 하단 탐색 모음에 어떤 항목을 강조 표시할지 알려줍니다.
        currentIndex: _selectedIndex,
        // 사용자가 탭 막대 항목을 탭하면 _onItemTapped 핸들러를 호출하여
        // 상태를 올바른 index로 업데이트합니다. 이 경우 색상이 변경됩니다.
        onTap: _onItemTapped, // tear-offs
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Card'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Card1'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Card2'
          )
        ],
      ),
    );
  }
}