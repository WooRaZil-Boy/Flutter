import 'package:flutter/material.dart';
import '../components/grocery_tile.dart';
import '../models/models.dart';
import 'grocery_item_screen.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({
    super.key,
    required this.manager,
  });

  final GroceryManager manager;

  @override
  Widget build(BuildContext context) {
    // 식료품 목록을 가져옵니다.
    final groceryItems = manager.groceryItems;

    // 화면 전체에 16픽셀의 패딩을 적용합니다.
    return Padding(
      padding: const EdgeInsets.all(16.0),
      // ListView를 추가합니다.
      child: ListView.separated(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) {
          final item = groceryItems[index];
          // 사용자가 왼쪽이나 오른쪽으로 스와이프하면 목록에서 항목을 지우는 위젯인 Dismissible을 사용합니다.
          // 세로 방향으로 스와이프하는 것도 지원합니다.
          // InkWell 안에 GroceryTile을 감쌉니다.
          return Dismissible(
            // Dismissible 위젯에는 Key가 포함됩니다.
            // Flutter가 트리에서 올바른 요소를 찾아서 제거하려면 이 키가 필요합니다.
            key: Key(item.id),
            // 사용자가 스와이프하여 해제할 수 있는 방향을 설정합니다.
            direction: DismissDirection.endToStart,
            // 사용자가 스와이프하는 위젯 뒤에 표시할 배경 위젯을 선택합니다.
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 50.0
              )
            ),
            // onDismissed는 사용자가 GroceryTile을 스와이프했을 때 이를 알려줍니다.
            onDismissed: (direction) {
              // 인덱스가 주어지면 식료품 관리자가 항목 삭제를 처리하도록 합니다.
              manager.deleteItem(index);
              // 스낵바 위젯을 표시하여 사용자가 어떤 항목을 삭제했는지 알려줍니다.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${item.name} dismissed'),),);
            },
            // 제스처 기반 위젯은 다양한 사용자 터치 동작을 감지합니다.
            // 제스처 위젯을 터치 동작이 필요한 다른 위젯에 둘러싸면 됩니다.
            // 제스처 위젯에서 주목해야 할 또 다른 사항은 히트 테스트 중에 제스처가 동작하는 방식을 제어하는
            // `HitTestBehavior`입니다. 여기에는 3가지 유형이 있습니다.
            //
            // - deferToChild: 터치 이벤트를 위젯 트리 아래로 전달합니다.
            //    이것은 GestureDetector의 기본 동작입니다.
            // - opaque: 백그라운드의 위젯이 터치 이벤트를 수신하지 못하도록 합니다.
            // - translucent: 백그라운드의 위젯이 터치 이벤트를 수신할 수 있도록 허용합니다.
            child: InkWell(
              // 각 항목에 대해 현재 항목을 가져와 GroceryTile을 구성합니다.
              child: GroceryTile(
                key: Key(item.id),
                item: item,
                // 체크박스를 탭하면 onComplete를 반환합니다.
                onComplete: (change) {
                  // 변경 사항이 있는지 확인하고 항목의 isComplete 상태를 업데이트합니다.
                  if (change != null) {
                    manager.completeItem(index, change);
                  }
                },
              ),
              // 제스처가 탭을 인식하면 사용자가 현재 항목을 편집할 수 있도록 GroceryItemScreen을 표시합니다.
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroceryItemScreen(
                      originalItem: item,
                      // 항목을 업데이트하면 GroceryItemScreen이 onUpdate를 호출합니다.
                      onUpdate: (item) {
                        // GroceryManager는 특정 인덱스에서 항목을 업데이트합니다.
                        manager.updateItem(item, index);
                        // GroceryItemScreen을 해제합니다.
                        Navigator.pop(context);
                      },
                      // 기존 항목을 업데이트하기 때문에 onCreate는 호출되지 않습니다.
                      onCreate: (item) {},
                    )
                  )
                );
              },
            ),
          );
        },
        // 각 항목의 간격을 16픽셀씩 띄웁니다.
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16.0);
        }
      ),

    );
  }
}



