import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/stock_search_data.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/w_popular_search_list.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/w_search_bar.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/w_search_history_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 's_stock_detail.dart';

class StockSearchScreen extends StatefulWidget {
  const StockSearchScreen({Key? key}) : super(key: key);

  @override
  State<StockSearchScreen> createState() => _StockSearchScreenState();
}

class _StockSearchScreenState extends State<StockSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  // searchData는 state 내에서 자주 사용되므로, 따로 변수로 선언해준다.
  // searchData는 initState에서 searchData.search(_controller.text); 로 값이 들어오게 되는데 
  // _StockSearchScreenState이 생성되는 시점에는 값이 없으므로 late 키워드를 사용해야 한다.
  late final searchData = Get.find<StockSearchData>();

  @override
  void initState() { 
    if (!Get.isRegistered<StockSearchData>()) {
      // GetXController를 사용하는 경우, Get.put을 사용하여 GetX를 등록해야 한다.
      Get.put(StockSearchData());
    }
    // Listener를 등록 시키면, 해당 컨트롤러의 값이 변경될 때마다 리스너가 호출된다.
    _controller.addListener(() {
      searchData.search(_controller.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    // 데이터를 지워준다.
    searchData.searchResult.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 해당 화면에서는 키보드가 올라가면서 화면을 덮게 되는데, Scaffold를 사용하면 해당 레이아웃을 자동으로 맞춰준다.
    return Scaffold(
      appBar: SearchBarWidget(controller: _controller),
      // GetX의 Obx를 사용하여 setState를 사용하지 않고도 화면을 갱신할 수 있다.
      // Obx를 사용하면, GetXController를 Rx 변수들을 관찰하여 값이 변경될 때마다 화면을 갱신한다.
      // 성능적으로도 setState는 전체 build를 갱신하지만, Obx는 해당 부분만 갱신한다.
      
      body: Obx(
        () => searchData.searchResult.isEmpty
            // ListView로 나타내야할 children이 많다면, builder를 사용하는 것이 좋다.
            ? ListView(
                children: const [
                  SearchHistoryList(),
                  PopularSearchList(),
                ],
              )
            : ListView.builder(
                itemCount: searchData.searchResult.length,
                itemBuilder: (BuildContext context, int index) {
                  final element = searchData.searchResult[index];
                  return Tap(
                    onTap: () {
                      Nav.push(StockDetail(stockName: element.name));
                      searchData.addSearchHistory(element.name);
                      _controller.clear();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: element.name.text.make(),
                    ),
                  );
                },
              ),
      ),
    );
  }
}