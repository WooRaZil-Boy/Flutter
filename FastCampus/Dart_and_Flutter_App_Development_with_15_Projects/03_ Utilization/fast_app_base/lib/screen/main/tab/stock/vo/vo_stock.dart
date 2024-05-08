import 'package:fast_app_base/screen/main/tab/stock/vo/vo_popular_stock.dart';

// 공통적인 부분은 상속받는다.
class Stock extends PopularStock {
  final String stockImagePath;

  Stock({
    required super.name,
    required super.yesterdayClosePrice,
    required super.currentPrice,
    required this.stockImagePath,
  });
}
