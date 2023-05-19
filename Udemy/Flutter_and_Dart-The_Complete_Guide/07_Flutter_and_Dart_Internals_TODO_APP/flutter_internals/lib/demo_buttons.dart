import 'package:flutter/material.dart';

class DemoButtons extends StatefulWidget {
  const DemoButtons({super.key});

  @override
  State<DemoButtons> createState() => _DemoButtonsState();
}

class _DemoButtonsState extends State<DemoButtons> {
  var _isUnderstood = false;

  @override
  Widget build(BuildContext context) {
    print('DemoButtons BUILD called');
    return Column(
      // Column의 크기를 수직으로 최소화한다.
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _isUnderstood = false;
                });
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isUnderstood = true;
                });
              },
              child: const Text('Yes'),
            ),
          ],
        ),
        // 이 앱의 state 업데이트는 Text 위젯에만 영향을 미친다. 따라서 새로운 위젯을 추가해 코드를 개선할 수 있다.
        if (_isUnderstood) const Text('Awesome!'),
      ],
    );
  }
}
