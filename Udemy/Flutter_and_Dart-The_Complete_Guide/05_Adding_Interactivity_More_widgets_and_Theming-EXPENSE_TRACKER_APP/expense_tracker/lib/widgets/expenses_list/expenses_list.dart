import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

// 리스트 내부 데이터를 관리하지 않고, 외부에서 데이터를 받아서 표시만 하므로 StatelessWidget으로 구현한다.
class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;

  const ExpensesList({
    super.key,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    // 길이를 정확히 모르는 List가 있어 아주 길어질 수 있다면, Column 대신 ListView를 사용하는 것이 좋다.
    // ListView는 기본적으로 스크롤 가능하다. 아이템은 보이거나 보이기 직전에만 생성될 수 있다.
    // ListView(children: [],); 을 사용하게 되면 리스트가 길어질 때 성능에 문제가 생길 수 있다.
    // 그 대신 ListView.builder()를 사용하여, 리스트의 길이에 상관없이 효율적으로 사용할 수 있다.
    return ListView.builder(
      itemCount: expenses.length,
      // itemBuilder로 리스트의 각 아이템을 생성한다. itemBuilder는 각 아이템이 필요한 경우에만 생성되도록 한다.
      // 컨텍스트 객체와 인덱스를 받아 Widget을 반환하며 itemCount에 따라 index를 받아서 사용한다.
      itemBuilder: (ctx, index) => ExpenseItem(expenses[index]),
    );
  }
}
