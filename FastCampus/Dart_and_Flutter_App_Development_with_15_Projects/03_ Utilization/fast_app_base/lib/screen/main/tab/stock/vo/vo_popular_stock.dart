import 'package:fast_app_base/screen/main/tab/stock/vo/vo_simple_stock.dart';

import 'stock_percentage_data_provider.dart';

class PopularStock extends SimpleStock with StockPercentageDataProvider {
  @override
  final int yesterdayClosePrice;
  @override
  final int currentPrice;

  PopularStock({
    required String name,
    required this.yesterdayClosePrice,
    required this.currentPrice,
  }) : super(name); // 생성시 상위 클래스의 생성자를 호출한다.
}
