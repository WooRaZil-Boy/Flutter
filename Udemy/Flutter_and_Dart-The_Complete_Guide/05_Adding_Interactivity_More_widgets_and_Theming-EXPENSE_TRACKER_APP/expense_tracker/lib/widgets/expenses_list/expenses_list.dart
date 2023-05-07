import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

// 리스트 내부 데이터를 관리하지 않고, 외부에서 데이터를 받아서 표시만 하므로 StatelessWidget으로 구현한다.
class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  // expense를 인자로 받는 함수를 가지고 있다가 해당 경우에 호출해 줘야 한다.
  final void Function(Expense expense) onRemoveExpense;

  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
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
      // Dismissible을 사용하면, 리스트의 아이템을 스와이프하여 삭제할 수 있다.
      // key는 Widget을 식별하기 위해 사용되는데, 대부분의 경우는 Widget에서 super.key로 사용하는 것이 전부이다.
      // 하지만 여기에서는 Dismissible을 사용하면서 삭제할 Widget을 식별하기 위해 key가 필요하다.
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        // background는 위젯이므로 배경색을 지정해 주기 위해서는 Container에 색을 지정해 주는 식으로 구현한다.
        // 삭제되는 것을 명확히 보여주기 위해 배경색을 추가한다.
        // context를 사용해, Theme에 접근할 수 있다.
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          // cardTheme으로 margin도 설정했기 때문에 그대로 가져와 사용할 수 있다.
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal
          ),
        ),
        child: ExpenseItem(expenses[index]),
        // onDismissed는 Dismissible이 사라질 때 호출되는 콜백이다.
        // key, child만 있어도 시각적으로는 정상적으로 삭제된다. 하지만, 실제로는 리스트에서는 삭제되지 않아 오류가 발생한다.
        // 따라서 내부 데이터에서도 삭제되도록, onDismissed를 구현한다.
        onDismissed: (direction) {
          // 스와이프 방향을 direction으로 받지만, 해당 경우에서는 사용할 필요가 없다.
          onRemoveExpense(expenses[index]);
        },
      ),
    );
  }
}
