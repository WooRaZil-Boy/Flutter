import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../../common/common.dart';
import '../../../../../common/util/local_json.dart';
import '../vo/vo_simple_stock.dart';

// GetX로 상태관리를 하기 위해서는 GetxController를 상속해야 한다.
class StockSearchData extends GetxController {
  List<SimpleStock> stocks = [];
  // RxList는 화면이 변경될 때마다 화면을 갱신하는 GetX의 리스트이다.
  // <String>[].obs 처럼 타입을 명시하고, obs를 붙여줘야 한다.
  RxList<String> searchHistoryList = <String>[].obs;
  RxList<SimpleStock> searchResult = <SimpleStock>[].obs;

  // GetX가 최초로 생성될 때 호출된다.
  @override
  void onInit() {
    searchHistoryList.addAll(['삼성전자', 'LG전자', '현대차', '넷플릭스']);
    () async {
      stocks.addAll(await LocalJson.getObjectList("json/stock_list.json"));
    }();
    super.onInit();
  }

  void search(String text) {
    // 첫 진입 시에도 text가 빈 문자열이므로, 검색 결과를 비워준다.
    if (isBlank(text)) {
      searchResult.clear();
      return;
    }
    // where로 stocks 리스트에서 조건에 맞는 요소만 필터링하여 새로운 리스트를 만들어준다.
    searchResult.value = stocks.where((element) => element.name.contains(text)).toList();
  }

  void addSearchHistory(String stockName) {
    searchHistoryList.insert(0, stockName);
  }
}
