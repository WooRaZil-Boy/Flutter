import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_cubit/cubits/cubits.dart';
import 'package:todo_cubit/models/todo_model.dart';

// searchTerm과 FilteredTodo 들로 필터링된 Todo 리스트만 보여준다.
class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosCubit>().state.filteredTodos;
    // Column 내에 ListView가 있으면 오류가 발생한다.
    //  1. ListView를 Expanded로 감싼다.
    //  2. ListView의 scrolling behavior를 수정한다(primary, shrinkWrap).
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          // Dismissible 위젯을 사용하면, 드래그로 아이템을 삭제할 수 있다.
          return Dismissible(
            key: ValueKey(todos[index].id),
            background: showBackground(0),
            secondaryBackground: showBackground(1),
            child: TodoItem(todo: todos[index]),
            onDismissed: (_) {
              context.read<TodoListCubit>().removeTodo(todos[index]);
            },
            confirmDismiss: (_) {
               return showDialog(
                context: context,
                // dialog 외부를 탭해도 사라지지 않는다.
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Are you sure'),
                    content: Text('Do you really want to delete?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false), 
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true), 
                        child: Text('Yes'),
                      )
                    ],
                  );
                }
              );
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(color: Colors.grey);
        },
        itemCount: todos.length);
  }

  Widget showBackground(int direction) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: Icon(
        Icons.delete,
        size: 30.0,
        color: Colors.white,
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;

  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // Dialog는 현재 위치에 scope 된 것이 아니다. TodoItem 위젯의 자식이 아니다.
        showDialog(
          context: context, 
          builder: (context) {
            bool _error = false;
            textController.text = widget.todo.desc;

            return StatefulBuilder(
              builder: (BuildContext contex, StateSetter setState) {
                return AlertDialog(
                  title: Text('Edit Todo'),
                  content: TextField(
                    controller: textController,
                    autofocus: true,
                    decoration: InputDecoration(
                      errorText: _error ? 'Value cannot be empty' : null
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context), 
                      child: Text('CANCEL')
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _error = textController.text.isEmpty ? true : false;
                          if (!_error) {
                            context.read<TodoListCubit>().editTodo(
                              widget.todo.id, 
                              textController.text
                            );
                            Navigator.pop(contex);
                          }
                        });
                      }, 
                      child: Text('EDIT')
                    )
                  ],
                );
              }
            );
          }
        );
      },
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
          context.read<TodoListCubit>().toggleTodo(widget.todo.id);
        },
      ),
      title:  Text(
        widget.todo.desc
      ),
    );
  }
}
