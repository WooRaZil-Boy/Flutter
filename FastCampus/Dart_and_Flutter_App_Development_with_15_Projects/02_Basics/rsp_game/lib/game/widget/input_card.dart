import 'package:flutter/material.dart';
import 'package:rsp_game/game/widget/input_contents.dart';

class InputCard extends StatelessWidget {
  const InputCard({super.key, this.callback, required this.child});

  final VoidCallback? callback;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // flutter outline을 이용하여 Widget을 확인하고 extract할 수 있다.
      child: InkWell(
        child: InputContents(child: child),
        onTap: () => callback?.call(),
      ),
    );
  }
}
