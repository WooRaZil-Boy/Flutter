import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

// 경비를 관리하고 추가할 수 있어야 하기 때문에 StatefulWidget이어야 한다.
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  // 더미 데터ㄹ 생성한다. List는 final로 할당하더라도 내부 아이템의 값은 변경 가능하다.
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Flutter Course",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Cinema",
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // 일반적으로 Scaffold을 사용하여 앱의 기본 레이아웃을 구성한다.
    return Scaffold(
      body: Column(
        children: [
          const Text('The chart!'),
          // buider 함수를 간소화하고 작은 단위의 Widget으로 나누는 것이 좋다.
          // Column 안에 List가 있는 구조이기 때문에 List가 제대로 표현되지 않는다.
          // Expanded를 사용하여 전체 화면을 사용하도록 해야 한다.
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses),
          ),
        ],
      ),
    );
  }
}
