import 'package:flutter/material.dart';

enum ColorSelection {
  // 구조화된 색상 옵션으로, 나열된 이름(예: Deep Purple)이 표시된다.
  deepPurple('Deep Purple', Colors.deepPurple),
  purple('Purple', Colors.purple),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink);

  // 각각 label과 color 객체를 가진다.
  const ColorSelection(
    this.label,
    this.color,
  );

  final String label;
  final Color color;
}

