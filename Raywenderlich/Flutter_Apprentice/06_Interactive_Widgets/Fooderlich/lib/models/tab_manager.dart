import 'package:flutter/material.dart';

// TabManager는 ChangeNotifier를 확장합니다. 이를 통해 객체가 리스너에게 변경 알림을 제공할 수 있습니다.
class TabManager extends ChangeNotifier {
  int selectedTab = 0;

  // goToTab()은 현재 탭 인덱스를 수정하는 간단한 함수입니다.
  void goToTab(index) {
    selectedTab = index;
    // notifyListeners()를 호출하여 이 상태를 수신하는 모든 위젯에 알립니다.
    notifyListeners();
  }

  // goToRecipes()는 selectedTab을 인덱스 1에 있는 Recipes 탭으로 설정하는 특정 함수입니다.
  void goToRecipes() {
    selectedTab = 1;
    // TabManager를 수신하는 모든 위젯에 Recipes가 선택된 탭임을 알립니다.
    notifyListeners();
  }
}