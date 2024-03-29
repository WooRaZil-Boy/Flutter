import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

// 관리해야 할 상태가 없으므로 StatelessWidget 이다.
class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    // Card를 사용하면 그림자가 들어간 박스를 만들 수 있으며, 상하단에 약간의 여백이 추가된다.
    return Card(
      child: Padding(
        // symmetric을 사용하면 상하/좌우에 대해 동일한 값으로 padding을 설정할 수 있다.
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        // 여러 행의 데이터를 표시해야 하므로 ListView가 필요하다. ListView는 기본적으로 스크롤 가능하다.
        // 하지만 여기서는 그리 많은 데이터가 아니므로 간단하게 Column을 사용할 수 있다.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title, 
              // context에서 theme을 가져올 수도 있다. main에서 설정한 값을 가져온다.
              // thmem을 그대로 가져오는 것뿐 아니라, copyWith를 사용하여 또 다시 일부만 변경할 수도 있다.
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                // double을 String으로 캐스팅해서 표현한다. toStringAsFixed을 사용하면 소수점 이하 자릿수를 지정할 수 있다.
                // interpolation을 사용할 때는 $을 사용하고, 표현식이나 함수를 포함할때는 ${}을 사용한다.
                // 이스케이핑을 위해서는 \를 사용한다. \$를 사용하면 $를 표현할 수 있다.
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                // Spacer는 가능한 공간을 모두 차지하며 Column과 Row에서 모두 사용할 수 있다.
                // Expanded와 비슷하지만, Expanded는 자식 위젯이 있어야 한다.
                // 따라서 여기에서는 양쪽의 Wdiget을 밀어내는 역할을 한다.
                const Spacer(),
                // 별도의 그룹핑을 위해 Row를 추가한다.
                Row(
                  children: [
                    // enum의 case 값을 String으로 사용할 수 있다. 동적으로 생성되기 때문에 const는 사용할 수 없다.
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    // 날짜를 String으로 캐스팅해 표현한다. getter를 사용하므로 ()를 사용하지 않는다.
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}