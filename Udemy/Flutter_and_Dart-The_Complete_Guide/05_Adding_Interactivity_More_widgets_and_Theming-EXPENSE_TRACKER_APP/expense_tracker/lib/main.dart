import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

void main() {
  runApp(
    MaterialApp(
      // Material3를 사용한다.
      theme: ThemeData(useMaterial3: true),
      home: const Expenses(),
    ),
  );
}