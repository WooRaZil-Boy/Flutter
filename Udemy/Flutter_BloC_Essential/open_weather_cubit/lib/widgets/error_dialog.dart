import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 자주 사용 되므로, Widget을 따로 관리하는 것이 좋다.
void errorDialog(BuildContext context, String errorMessage) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: [
            CupertinoActionSheetAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context), 
            )
          ],
        );
      }
    );
  } else {
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      }
    );
  }
}