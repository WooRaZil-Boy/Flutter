import 'package:flutter/material.dart';
import 'empty_grocery_screen.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import 'grocery_item_screen.dart';
import 'grocery_list_screen.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // + 아이콘이 있는 플로팅 액션 버튼을 추가합니다.
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final manager = Provider.of<GroceryManager>(
            context,
            listen: false
          );
          // Navigator.push()는 route 스택에 새 route를 추가합니다.
          Navigator.push(
            context,
            // MaterialPageRoute는 전체 화면을 플랫폼별 트랜지션으로 바꿉니다.
            // 안드로이드에서는 위로 슬라이드하여 페이드 인합니다. iOS에서는 오른쪽에서 슬라이드 인합니다.
            MaterialPageRoute(
              builder: (context) => GroceryItemScreen(
                onCreate: (item) {
                  manager.addItem(item);
                  Navigator.pop(context);
                },
                onUpdate: (item) {}
              )
            )
          );
        },
      ),
      body: buildGroceryScreen()
    );
  }

  // buildGroceryScreen()은 어떤 위젯 트리를 구성할지 결정하는 헬퍼 함수입니다.
  Widget buildGroceryScreen() {
    // 위젯을 Consumer 안에 감싸고, Consumer는 GroceryManager 상태 변경을 수신합니다.
    // 필요한 위젯에만 Consumer를 래핑해야 합니다.
    // 예를 들어, Consumer 위젯을 최상위 레벨에 래핑하면 전체 트리를 다시 빌드해야 합니다!
    return Consumer<GroceryManager>(
      // Consumer는 GroceryManager 항목이 변경되면 그 아래에 있는 위젯을 다시 빌드합니다.
      builder: (context, manager, child) {
        // groceryItem이 있으면 GroceryListScreen을 표시합니다.
        if (manager.groceryItems.isNotEmpty){
          return GroceryListScreen(manager: manager);
        } else {
          // groceryItem이 없는 경우 EmptyGroceryScreen을 표시합니다.
          return const EmptyGroceryScreen();
        }
      },
    );
  }
}
