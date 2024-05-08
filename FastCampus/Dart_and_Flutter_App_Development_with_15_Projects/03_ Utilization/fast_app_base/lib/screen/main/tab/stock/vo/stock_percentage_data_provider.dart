import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

// 일반적으로 Model에서 값을 가지고 있는 필드 외에 계산해야 하는 부분이 필요할 때는 mixin을 사용하는 것이 좋다.
// Model에 직접 계산하는 getter와 메서드를 추가할 수 있지만, Model은 데이터만 가지고 있는 역할을 하는 것이 좋다.
// mixin을 여러 개 구현하는 경우, 변수명이 겹치면 뒤에 구현된 것만 제대로 동작할 수 있으니 유의해야 한다.
abstract mixin class StockPercentageDataProvider {
  // abstract를 사용하여 구현해야 할 필드를 정의한다.
  int get currentPrice;

  int get yesterdayClosePrice;

  double get todayPercentage =>
      ((currentPrice - yesterdayClosePrice) / yesterdayClosePrice * 100).toPrecision(2);

  String get todayPercentageString => _isPlus ? '+$todayPercentage%' : '$todayPercentage%';

  bool get _isPlus => currentPrice > yesterdayClosePrice;

  bool get _isSame => currentPrice == yesterdayClosePrice;

  Color getTodayPercentageColor(BuildContext context) {
    if (_isSame) {
      return context.appColors.dimmedText;
    } else if (_isPlus) {
      return context.appColors.plus;
    } else {
      return context.appColors.minus;
    }
  }
}
