import 'package:flutter/material.dart';
import 'grocery_item.dart';

// GroceryManager는 ChangeNotifier을 확장하여 상태 변경에 대해 수신자에게 알립니다.
class GroceryManager extends ChangeNotifier {
  // _groceryItems는 비공개 리스트입니다.
  final _groceryItems = <GroceryItem>[];

  // 수정할 수 없는 _groceryItems에 대한 공용 getter 메서드를 제공합니다.
  // 외부 엔티티는 groceryItems만 읽을 수 있습니다.
  List<GroceryItem> get groceryItems => List.unmodifiable(_groceryItems);

  // 각 메서드는 notifyListeners()를 호출합니다.
  // 위젯에 리빌드가 필요한 GroceryManager의 변경 사항을 알립니다.

  void deleteItem(int index) {
    _groceryItems.removeAt(index);
    notifyListeners();
  }

  void addItem(GroceryItem item) {
    _groceryItems.add(item);
    notifyListeners();
  }

  void updateItem(GroceryItem item, int index) {
    _groceryItems[index] = item;
    notifyListeners();
  }

  void completeItem(int index, bool change) {
    final item = _groceryItems[index];
    _groceryItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
}