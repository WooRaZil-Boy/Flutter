import 'package:flutter/material.dart';

// 내부 상태를 관리해야 하기 때문에 StatefulWidget이어야 한다.
class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // 처음에는 빈 문자열이다.
  var _enteredTitle = '';

  // 저장 방법에는 두 가지가 있다.
  // 첫 번째 접근법은 텍스트 필드에 다른 매개변수를 추가하는 것이다.(onChanged 매개변수)
  // 텍스트 필드의 값이 바뀔 때마다 트리거되는 함수를 등록한다.
  void _saveTitleInput(String inputValue) {
    // 해당 함수가 호출될 때 마다 새 값을 할당한다. 할당한 값을 어디에서도 사용하지 않으므로 setState를 호출할 필요가 없다. UI 업데이트가 필요없다.
    // 대신, 확인 버튼을 누르는 경우 해당 저장되어 있던 해당 값을 사용한다.
    _enteredTitle = inputValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      // 지금은 스크롤이 필요하지 않고, 항목을 동적으로 생성할 필요도 없기 때문에 ListView 대신 Column을 사용한다.
      child: Column(
        children: [
          // TextField로 사용자가 텍스트를 입력할 수 있다.
          TextField(
            // 이 외에도 매우 다양한 속성이 있어 커스터마이징할 수 있다.
            onChanged: _saveTitleInput,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // 버튼을 눌렀을 때 입력한 최신 값을 가져온다.
                  print(_enteredTitle);
                },
                child: const Text('Save Expense'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
