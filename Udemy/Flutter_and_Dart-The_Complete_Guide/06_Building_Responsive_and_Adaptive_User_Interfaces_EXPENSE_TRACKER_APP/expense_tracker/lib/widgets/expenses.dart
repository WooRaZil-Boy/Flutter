import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      // bottom 뿐 아니라 top 에 대해서도 확인해 봐야 한다. 카메라나 status bar 등의 높이가 디바이스 별로 다르기 때문이다.
      // 단순히 고정된 숫자를 넣어서 해결할 수도 있지만, safeArea를 사용하는 것이 나은 해결 방법이 있다.
      // 위젯별로 내장된 매커니즘이 있는 경우도 있다. 예를 들어, Appbar의 경우는 자동으로 카메라나 status bar 등의 높이를 고려해서 위치를 설정한다.
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // context는 중요한 메타정보이다. 위젯 트리에서 실행되는 위젯의 위치정보를 포함하고 있다.
    // 아래 값은 회전할 때마다 바로 반영이 된다.
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    // Scaffold 위젯은 내부적으로 safeArea를 사용한다.
    return Scaffold(
      appBar: AppBar(
        // iOS에서는 중앙정렬이 기본이지만, Android에서는 좌측정렬이 기본이다.
        // iOS에서도 좌측정렬이 되게 하려면
        // centerTitle: false, 를 추가해야 한다.
        // Flutter에서는 글자 폰트도 기본값이 OS에 따라 다르다.
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      // 너비를 확인하여, 가로 모드일때 Column을 Row로 바꾼다.
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
            // 위젯은 부모 위젯에 적용된 제약조건을 고려하여 크기를 결정한다.
            // Column은 가능한 한 height를 확보하려 하지만, 가장 큰 하위 아이템이 정의하는 만큼의 width가 필요하다.
            // 따라서 이를 제한하는 상위 위젯이 없다면, 화면 경계 밖으로 나갈수도 있다.
            // Scaffold 위젯은 높이와 너비를 제한하기 때문에 child로 Column을 추가하면 해당 Column에도 제한이 생긴다.
            // ListView도 Column과 동일하다. height에 제약조건이 따로 없기 때문에 가능한 최대한의 높이를 차지하려 한다.
            // 따라서 Expanded 위젯이 필요하다. 여기서 height의 제한을 추가하게 된다.
          : Row(
              children: [
                // 가로모드일 때는 차트가 Row에서 표현이 되는데, 부모와 자식의 위젯이 모두 너비를 최대한으로 늘리려 하기 때문에 차트가 제대로 보여지지 않고 오류가 발생한다.
                // 따라서 차트도 Expanded로 감싸주어야 한다.
                Expanded(
                  // Chart는 Container가 감싸고 있다.
                  child: Chart(expenses: _registeredExpenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}