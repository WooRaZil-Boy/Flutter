import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

// 경비를 관리하고 추가할 수 있어야 하기 때문에 StatefulWidget이어야 한다.
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  // 더미 데이터 생성한다. List는 final로 할당하더라도 내부 아이템의 값은 변경 가능하다.
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

  // 해당 메서드는 동적으로 새로운 UI 요소를 추가한다. 실행될 때 마다 새로운 UI 요소를 생성한다.
  void _openAddExpenseOverlay() {
    // State의 context를 사용할 수 있다.
    // context는 위젯 트리에서 현재 위치를 나타내는 객체로 메타 데이터의 컬렉션으로 생각할 수 있다.
    // builder인수에는 기본적으로 값을 갖는 함수를 제공해야 한다. 이 함수는 새로운 위젯을 반환한다.
    // 여기서의 ctx는 컨텍스트를 나타내지만, State의 context와는 다르다.
    // showModalBottomSheet를 사용하면, 백그라운드를 탭하여 해당 ModalBottomSheet를 자연스럽게 닫을 수 있다.
    showModalBottomSheet(
      // isScrollControlled을 true로 하면, 모듈 오버레이가 사용 가능한 모든 높이를 차지하게 된다. 키보드가 겹치는 걸 방지할 수 있다.
      // 하지만, 이는 status bar와 카메라를 포함한 모든 공간을 차지 하므로, new_expense에 padding을 추가해 준다.
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      // 새로운 항목을 추가하고, 화면을 다시 그린다.
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    // 해당 expense의 index를 찾는다.
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      // 해당 항목을 제거하고, 화면을 다시 그린다.
      _registeredExpenses.remove(expense);
    });

    // 한 번에 여러 항목을 동시에 제거하면, 스낵바가 아직 사라지지 않은 상태이기 때문에, 이전 스낵바가 dismiss 될 때까지 기다렸다가 노출된다.
    // 따라서 스낵바가 열릴 때, 이전의 스낵바를 먼저 제거해 주도록 한다.
    ScaffoldMessenger.of(context).clearSnackBars();

    // 실수로 목록의 아이템을 삭제한 경우, 다시 복구할 수 있도록 한다.
    // State 클래스에 기반한 것이기에, 해당 클래스의 context를 넘겨준다.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              // 제거한 항목을 이전의 위치에 다시 추가해야 하기 때문에 add가 아닌 insert를 사용해야 한다.
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 목록이 비었을 경우, 보여줄 위젯을 생성한다.
    Widget mainContent = const Center(
      child: Text('No expenses founds. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses, 
        onRemoveExpense: _removeExpense
      );
    }

    // 일반적으로 Scaffold을 사용하여 앱의 기본 레이아웃을 구성한다.
    return Scaffold(
      // Row로 Add 버튼이 있는 Toolbar를 생성할 수 있다. 하지만 Scaffold의 AppBar를 사용하는 것이 더 좋다.
      // appBar는 PreferredSizeWidget을 받는다. 특정 종류의 위젯만 사용한다. 보통 AppBar를 사용한다.
      // AppBar를 사용하면, 콘텐츠가 화면의 가장자리에 맞추어 배치되며 카메라 statusBar등의 필요한 공간을 자동으로 계산한다.
      appBar: AppBar(
        title: const Text('Flutter ExpensesTracker'),
        // actions로 AppBar에 버튼을 추가한다.
        actions: [
          IconButton(
            // tear-off를 사용하여, ()없이 메서드를 호출할 수 있다.
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          // buider 함수를 간소화하고 작은 단위의 Widget으로 나누는 것이 좋다.
          // expenses가 Column을 표시하기 때문에, Column 안에 또 다른 Column이 있고 그 안에 List가 있다.
          // Flutter는 내부 Column의 크기를 어떻게 제한 할지 모르기 때문에 리스트가 제대로 표현되지 않는다.
          // 따라서 Expanded를 사용하여 감싸고, Expanded의 child로 내부의 Column이나 ListView가 설정되도록 해야 한다.
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
