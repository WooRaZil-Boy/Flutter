import 'package:fast_app_base/common/theme/custom_theme.dart';

import 'app_preferences.dart';

// 로컬에 저장할 데이터를 정의한다.
// RxPreferenceItem를 사용하여 실시간으로 변경되는 데이터를 받아올 수 있다.
class Prefs {
  static final appTheme = NullablePreferenceItem<CustomTheme>('appTheme');
  static final isPushOn = PreferenceItem<bool>('isPushOn', false);
  static final isPushOnRx = RxPreferenceItem<bool, RxBool>('isPushOnRx', false);
  static final sliderPosition = RxPreferenceItem<double, RxDouble>('sliderPosition', 0.0);
  // null을 기본값으로 주기 위해서는 RxnPreferenceItem을 사용한다.
  static final birthday = RxnPreferenceItem<DateTime, Rxn<DateTime>>('birthday');
  static final number = RxPreferenceItem<int, RxInt>('number', 0);
}
