import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/grocery_tile.dart';
import '../models/models.dart';

class GroceryListScreen extends StatelessWidget {
  final GroceryManager manager;

  const GroceryListScreen({
    super.key,
    required this.manager,
  });

  @override
  Widget build(BuildContext context) {
    final groceryItems = manager.groceryItems;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) {
          final item = groceryItems[index];
          return Dismissible(
            key: Key(item.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 50.0,
              ),
            ),
            onDismissed: (direction) {
              manager.deleteItem(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.name} dismissed'),
                ),
              );
            },
            child: InkWell(
              child: GroceryTile(
                key: Key(item.id),
                item: item,
                onComplete: (change) {
                  if (change != null) {
                    manager.completeItem(index, change);
                  }
                },
              ),
              onTap: () {
                // 장보기 목록에서 특정 인덱스를 탭할 때 해당 인덱스의 itemId를 가져옵니다.
                final itemId = manager.getItemId(index);
                // To Buy 탭에서 특정 품목으로 이동하여 itemId를 지정합니다.
                context.goNamed(
                  'item',
                  params: {
                    'tab': '${FooderlichTab.toBuy}',
                    'id': itemId
                  },
                );
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16.0);
        },
      ),
    );
  }
}
