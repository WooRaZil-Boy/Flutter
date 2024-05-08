import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OsSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const OsSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    // 플랫폼에 따라서 switch 모양이 다르게 보여준다.
    return Platform.isIOS
        ? CupertinoSwitch(
            value: value,
            onChanged: onChanged,
          )
        : Switch(
            value: value,
            onChanged: onChanged,
          );
  }
}
