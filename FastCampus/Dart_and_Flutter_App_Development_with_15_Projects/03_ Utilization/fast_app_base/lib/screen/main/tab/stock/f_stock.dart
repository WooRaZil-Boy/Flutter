import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/widget/w_image_button.dart';
import 'package:fast_app_base/screen/main/tab/stock/search/s_stock_search.dart';
import 'package:fast_app_base/screen/main/tab/stock/tab/f_my_stock.dart';
import 'package:fast_app_base/screen/main/tab/stock/tab/f_todays_discovery.dart';
import 'package:flutter/material.dart';

import 'setting/s_setting.dart';

class StockFragment extends StatefulWidget {
  const StockFragment({Key? key}) : super(key: key);

  @override
  State<StockFragment> createState() => _StockFragmentState();
}

// mixin은 with 키워드를 사용하여 다중 상속을 할 수 있다.
class _StockFragmentState extends State<StockFragment> with SingleTickerProviderStateMixin {
  // late없이 바로 this를 사용할 수 없다. _StockFragmentState가 생성될 때, 생성되는 과정에서는 초기화되지 않은 this를 사용할 수 없다.
  // 따라서 late 키워드를 사용하거나, nullable로 선언하여 initState에서 초기화해야 한다.
  late final _tabController = TabController(length: 2, vsync: this);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: context.appColors.roundedLayoutBackground,
          pinned: true, // 스크롤을 해도 AppBar가 사라지지 않아야 한다.
          actions: [
            // 공통 widget을 만들어서 사용한다.
            ImageButton(
              imagePath: '$basePath/icon/stock_search.png',
              onTap: () {
                Nav.push(const StockSearchScreen());
              },
            ),
            ImageButton(
              imagePath: '$basePath/icon/stock_calendar.png',
              onTap: () {
                context.showSnackbar('캘린더');
              },
            ),
            ImageButton(
              imagePath: '$basePath/icon/stock_settings.png',
              onTap: () {
                Nav.push(const SettingScreen());
              },
            ),
          ],
        ),
        // 박스로 감싸는 sliver
        SliverToBoxAdapter(
          child: Column(
            children: [
              title,
              tabBar,
              if (currentIndex == 0) const MyStockFragment() else const TodaysDiscoveryFragment(),
            ],
          ),
        ),
      ],
    );
  }

  Widget get title => Row(
        crossAxisAlignment: CrossAxisAlignment.end, // 진행방향의 반대는 crossAxisAlignment를 사용하여 정렬한다.
        children: [
          '토스증권'.text.size(24).bold.make(),
          width20,
          'S&P 500'.text.size(13).bold.color(context.appColors.lessImportant).make(),
          width10,
          3919.29.toComma().text.size(13).bold.color(context.appColors.plus).make(),
        ],
      ).pOnly(left: 20);

  Widget get tabBar => Column(
        children: [
          TabBar(
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            labelPadding: const EdgeInsets.symmetric(vertical: 20),
            indicatorColor: Colors.white,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
            controller: _tabController, // nullable인데 넣어주지 않으면 오류가 난다...?
            tabs: [
              '내 주식'.text.make(),
              '오늘의 발견'.text.make(),
            ],
          ),
          const Line(),
        ],
      );
}
