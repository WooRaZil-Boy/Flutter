import 'package:flutter/material.dart';
import 'package:flutter_internals/demo_buttons.dart';

// State가 변경되는 부분만 따로 떼어내어 StatefulWidget으로 만들면, UIUpdatesDemo는 StatelessWidget으로 만들 수 있다.
// DemoButtons에서 yes를 눌러 해당 부분이 업데이트 되어도, UIUpdatesDemo는 변경되는 부분이 없으므로 업데이트 되지 않는다.
// 작은 프로젝트에서는 크게 영향을 주지 않지만, StatefulWidget이 많아지면 성능에 영향을 미치게 된다.
class UIUpdatesDemo extends StatelessWidget {
  const UIUpdatesDemo({super.key});

  // createElement는 StatefulWidget이 처음 생성될때 호출된다. 즉, Element Tree에 해당 element를 추가한다.
  // 해당 element를 재사용하게 된다면, 이미 추가되어 있으므로 호출되지 않는다.
  // @override
  // StatefulElement createElement() {
  //   print('UIUpdatesDemo CREATEELEMENT called');
  //   return super.createElement();
  // }

  // @override
  // State<UIUpdatesDemo> createState() {
  //   return _UIUpdatesDemo();
  // }

  // build 메서드 위젯의 상태가 변경되어 다시 그려야 하는 경우 호출된다.
  @override
  Widget build(BuildContext context) {
    print('UIUpdatesDemo BUILD called');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Every Flutter developer should have a basic understanding of Flutter\'s internals!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Do you understand how Flutter updates UIs?',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            DemoButtons(),
          ],
        ),
      ),
    );
  }
}
