import 'package:flutter/material.dart';

// 경비를 관리하고 추가할 수 있어야 하기 때문에 StatefulWidget이어야 한다.
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  @override
  Widget build(BuildContext context) {
    // 일반적으로 Scaffold을 사용하여 앱의 기본 레이아웃을 구성한다.
    return Scaffold(
      body: Column(
        children: const [
          Text('The chart!'),
          Text('Expenses list...'),
        ],
      ),
    );
  }
}