import 'package:flutter/material.dart';

import 'package:adv_basics/quiz.dart';

// 디버그 모드에서 앱을 실행하여 특정 디버깅 기능을 사용할 수도 있다.
// 디버그 모드를 사용하려면 실행 중인 앱을 다시 시작해야 한다.
// Run -> Start Debugging을 선택하거나, F5를 누르면 된다. 또는 main 함수 위의 debug를 선택해도 된다.
// 앱이 조금 느리게 빌드 되지만 앱 분석을 위한 여러 가지 추가 기능을 제공한다.
void main() {
  runApp(const Quiz());
}

// VSC를 시작할 때, Flutter DevTools를 자동으로 실행할지 물어보는데, 이를 설정할 수도 있고
// Flutter DevTools를 따로 실행하여 앱의 성능을 분석하고 디버깅할 수 있다. 보통은 웹브라우저로 여는 것이 좋다.
// performance도 측정할 수 있지만, Debug 모드로 실행하면 디버깅을 위한 여러 툴들이 함께 실행되어 성능이 제대로 측정되지 않는다.
// 이런 경우에는 main 함수 위의 profile 을 선택하여 앱을 실행한다.
// 가장 자주 사용하는 것은 Flutter Inspector이다.
// 인터페이스에서 무슨 일이 일어나는지 이해할 수 있으며 각 위젯의 부모, 너비, 높이 등도 확인할 수 있다.
// Layout Explorer에서는 레이아웃을 시각화하여 확인할 수 있고, 설정을 직접 바꿔 위젯의 변경점을 볼 수 있다.
// 또한, Select Widget Mode를 사용하여 직접 앱에서 위젯을 선택하고 해당 위젯의 속성을 확인할 수 있다.