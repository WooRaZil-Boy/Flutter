import 'package:flutter/material.dart';
import 'package:flutter_internals/keys/checkable_todo_item.dart';

// import 'package:flutter_internals/keys/todo_item.dart';

class Todo {
  const Todo(this.text, this.priority);

  final String text;
  final Priority priority;
}

class Keys extends StatefulWidget {
  const Keys({super.key});

  @override
  State<Keys> createState() {
    return _KeysState();
  }
}

class _KeysState extends State<Keys> {
  var _order = 'asc';
  final _todos = [
    const Todo(
      'Learn Flutter',
      Priority.urgent,
    ),
    const Todo(
      'Practice Flutter',
      Priority.normal,
    ),
    const Todo(
      'Explore other courses',
      Priority.low,
    ),
  ];

  List<Todo> get _orderedTodos {
    // _todos를 복사한다.
    // List.of()를 사용하면, 원본의 리스트를 변경하지 않고 새로운 리스트를 생성한다.
    final sortedTodos = List.of(_todos);
    // 정렬 방법을 정의한다.
    sortedTodos.sort((a, b) {
      final bComesAfterA = a.text.compareTo(b.text);
      return _order == 'asc' ? bComesAfterA : -bComesAfterA;
    });
    return sortedTodos;
  }

  // 모든 위젯은 Element를 가지고 있다(Element Tree).
  // 여기서 순서가 변경된다고 해도, Element Tree의 뼈대는 그대로이다. 같은 Element의 구조를 유지하고, 새로운 Element를 생성하지 않는다.
  // 대신 어떤 Element가 어떤 Widget을 의미하는지 업데이트해 준다. 
  // 여기서 순서가 바뀌었다고 해도, Widget 자체가 바뀐것은 아니며 여전히 같은 형식의 Widget이다.
  // 몇 개의 순서가 바뀔 수 있지만, TodoItem의 count와 Widget은 동일하다.
  // 이런 경우 Flutter는 새로운 Widget을 생성하는 것이 아니라 이미 있는 Widget을 재사용한다.
  // 그러면서 해당 Element가 어떤 Widget을 의미하는 지 추적해서 Widget의 보여줄 수 있는 콘텐츠를 확인한다.
  // Flutter는 모든 Element를 Widget에 연결한다. 따라서 여기서는 모든 Element를 재사용하면서 참조를 업데이트 한다.
  // 이런 업데이트를 위해 key가 필요하다.
  void _changeOrder() {
    setState(() {
      _order = _order == 'asc' ? 'desc' : 'asc';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: _changeOrder,
            icon: Icon(
              _order == 'asc' ? Icons.arrow_downward : Icons.arrow_upward,
            ),
            label: Text('Sort ${_order == 'asc' ? 'Descending' : 'Ascending'}'),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              // for (final todo in _orderedTodos) TodoItem(todo.text, todo.priority),
              // 중괄호 없이 반복문을 사용해서 Item을 구성한다.
              for (final todo in _orderedTodos)
                // TodoItem(
                // 이전의 TodoItem 대신 CheckableTodoItem을 사용하면서 key를 전달하지 않으면, 제대로 작동하지 않는다. 
                // 이전과 동일하게 순서는 잘 변경되지만, 체크 표시가 제대로 반영되지 않는다.
                // Flutter가 레퍼런스를 관리하긴 하지만, 다른 방식으로 관리되기 때문이다. CheckableTodoItem은 StatefulWidget이고, 
                // State들은 Widget이 아닌 Element에 연결이 된다. 따라서 여기서 Widget을 정렬하여 위치를 바꿔도 State가 변경되지는 않는다.
                // 이전의 TodoItem을 사용하더라도, Wdiget의 위치가 바뀔뿐, Element Treee에 연결된 State는 변경되지 않고 그대로 위치한다.
                // 이를 해결하기 위해 필요한 것이 key이다. 
                // 이전의 TodoItem는 따로 State의 값을 사용할 필요가 없었기 때문에 잘 작동한 것처럼 보인다. 이처럼 대부분의 경우는 key가 필요없다.
                // 하지만 CheckableTodoItem은 State의 값을 사용하기 때문에 key를 전달해 주지 않으면 바로 오류가 난 것처럼 보인다.

                // key를 사용하게 되면, Widget Tree와 Element Tree의 식별자로 key가 추가된다. 
                // 정렬, 추가, 삭제 등의 동작으로 key가 일치하지 않는다는 걸 알게 되면 State도 같이 변경된다.
                // 따라서, 모든 Widget에는 key를 사용하는 것이 권장된다.
                CheckableTodoItem(
                  todo.text,
                  todo.priority,
                  // 주로 사용하는 key는 두가지가 있다.
                  // ValueKey는 생성자에서 dynamic 값을 받는다. 중복되지 않는 유일한 하나의 값만 넘겨주면 된다.
                  // ObjectKey는 생성자에서 Object를 받는다. 따라서, Object의 멤버가 있다면 전부 작성해서 넘겨줘야 한다.
                  // ValueKey가 간편해서 주로 사용되지만, 0, "1"과 같은 값은 사용하지 않는 것이 좋다.
                  key: ValueKey(todo.text),
                ),
            ],
          ),
        ),
      ],
    );
  }
}