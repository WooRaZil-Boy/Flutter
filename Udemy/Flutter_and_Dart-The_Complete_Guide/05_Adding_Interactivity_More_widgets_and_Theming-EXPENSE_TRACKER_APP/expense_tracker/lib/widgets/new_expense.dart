import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

// 내부 상태를 관리해야 하기 때문에 StatefulWidget이어야 한다.
class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // // 처음에는 빈 문자열이다.
  // var _enteredTitle = '';

  // // 저장 방법에는 두 가지가 있다.
  // // 첫 번째 접근법은 텍스트 필드에 다른 매개변수를 추가하는 것이다.(onChanged 매개변수)
  // // 텍스트 필드의 값이 바뀔 때마다 트리거되는 함수를 등록한다.
  // void _saveTitleInput(String inputValue) {
  //   // 해당 함수가 호출될 때 마다 새 값을 할당한다. 할당한 값을 어디에서도 사용하지 않으므로 setState를 호출할 필요가 없다. UI 업데이트가 필요없다.
  //   // 대신, 확인 버튼을 누르는 경우 해당 저장되어 있던 해당 값을 사용한다.
  //   _enteredTitle = inputValue;
  // }

  // 하지만 위의 방법은 텍스트 필드가 변경될 때마다 매번 함수가 호출되고, 수동으로 값을 할당해 줘야 한다.
  // 대신 Futter가 제공하는 TextEditingController를 사용할 수 있다.
  // TextEditingController는 사용자 입력 처리를 위한 편리한 기능을 제공한다.
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  // 처음에는 선택된 값이 없으므로 null 이다. 따라서 var를 사용한다.
  DateTime? _selectedDate;
  // DropdownButton은 Controller를 지원하지 않는다. 선택한 값을 직접 저장해 둬야 한다.
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    // 현재의 1년 전 날짜를 생성한다.
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    // showBottomSheet 처럼, DatePicker를 보여준다.
    // showDatePicker는 Future<DateTime?>을 반환한다.
    // then을 사용하여 처리할 수도 있지만, 여기서는 async/await를 사용한다.
    // Widget의 build 메서드는 Future를 반환할 수 없기 때문에, async/await를 사용할 수 없다.
    // 따라서 메서드 반환값을 받을 수 있는 변수를 선언하고, 그 변수에 await를 사용하여 반환값을 할당한다.
    // await를 사용하면, 지금 당장은 사용할 수 없는 값이지만, 미래에는 사용가능한 값을 반환할 수 있다.
    // Flutter는 그 값을 기다려 해당 변수에 할당한다. 따라서 이후의 코드는 해당 변수에 할당된 값을 사용할 수 있다.
    final pickedDate = await showDatePicker(
        context: context,
        // 시작 날짜
        initialDate: now,
        // min Date
        firstDate: firstDate,
        // max Date
        lastDate: now);

    setState(() {
      // 사용자가 날짜를 선택하지 않고 취소하는 경우, null이 반환된다.
      // 따라서, null인 경우에는 아무것도 하지 않는다.
      if (pickedDate == null) {
        return;
      }

      // 사용자가 날짜를 선택하면, 해당 날짜를 할당한다.
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    // 하지만, TextEditingController를 사용하면, 위젯을 더 이상 사용하지 않을 때 반드시 dispose를 호출해 메모리 누수를 방지해야 한다.
    _titleController.dispose();
    _amountController.dispose();

    super.dispose();
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
            // onChanged: _saveTitleInput,
            // onChanged에 함수 대신 컨트롤러를 등록한다. 필드가 여러 개라면 컨트롤러도 여러 개가 필요하다.
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              // amount를 입력하는 TextField는 일반적으로 몇 개의 숫자만 입력하므로 행 전체를 쓸 필요가 없다.
              // 따라서 Row의 children으로 넣어주고, 남는 공간을 활용할 수 있다.
              // TextField는 가능한 많은 공간을 차지하려 하고, Row는 기본적으로 차지할 수 있는 공간을 제한하지 않기 때문에
              // Row 밑에 TextField를 배치할 때 주로 레이아웃에 문제가 생길 수 있다. 따라서, Expanded를 사용하여 남은 공간만 차지하도록 해주는 것이 좋다.
              Expanded(
                child: TextField(
                  controller: _amountController,
                  // amount만 입력하므로 키보드를 숫자로 제한할 수 있다.
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    // escaping을 위해 \를 붙여준다. 텍스트 입력 시 앞에 $가 보여진다.
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Expanded를 사용하여 남은 공간을 모두 채운다.
              Expanded(
                child: Row(
                  // Row를 우측 정렬하여 끝에 배치한다.
                  mainAxisAlignment: MainAxisAlignment.end,
                  // 수직으로도 정렬을 추가해 준다.
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      // expense에서 formatter를 선언했기 때문에 해당 패키지를 가져와 사용할 수 있다.
                      _selectedDate == null
                          ? 'No date selected'
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                // 선택한 값이 보여지도록 한다.
                value: _selectedCategory,
                // 열거형을 values로 모든 값들을 가져올 수 있다.
                // values는 열거형 값들의 리스트이다. 따라서 이를 DropdownMenuItem의 리스트로 변경해야 한다.
                // 열거형은 name으로 해당 case의 이름을 String으로 가져올 수 있다.
                // map의 반환형은 Iterable이므로, toList를 사용해 리스트로 변경해야 한다.
                items: Category.values
                  .map(
                    (category) => DropdownMenuItem(
                      // value는 사용자에게 보여지지 않는 내부적으로 저장되는 값이다. 사용자가 드랍다운에서 해당 아이템을 선택하는 순간 해당 값이 보내지게 된다.
                      // Object? 유형을 받으므로 열거형 값 그대로 value에 설정할 수 있다.
                      value: category,
                      child: Text(
                        category.name.toUpperCase(),
                      ),
                    ),
                  )
                  .toList(),
                onChanged: (value) {
                  // 사용자가 드롭다운에서 아이템을 하지 않으면 null이 반환되어 바로 종료한다.
                  if (value == null) {
                    return;
                  }

                  // 메서드를 사용할 수도 있지만, 여기서 바로 setState를 사용해도 된다.
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // build의 context를 사용하여 현재 위젯을 닫는다.
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // 버튼을 눌렀을 때 입력한 최신 값을 가져온다.
                  // print(_enteredTitle);
                  // TextEditingController를 사용하면, 직접 입력값을 저장하고 있을 필요가 없다.
                  print(_titleController.text);
                  print(_amountController.text);
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
