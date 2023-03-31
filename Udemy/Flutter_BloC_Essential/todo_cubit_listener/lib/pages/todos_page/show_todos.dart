import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_cubit_listener/cubits/cubits.dart';
import 'package:todo_cubit_listener/models/todo_model.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosCubit>().state.filteredTodos;
    
    // BlocListener를 사용하더라도 위젯을 그리는데 todoFilterCubit, todoSearchCubit, todoListCubit이 필요하다.
    return MultiBlocListener(
      listeners: [
        // BlocListener는 one-time action 이기 때문에 watch가 아닌 read이다.
        BlocListener<TodoListCubit, TodoListState>(
          listener: (context, state) {
            context.read<FilteredTodosCubit>().setFilteredTodos(
              context.read<TodoFilterCubit>().state.filter,
              state.todos,
              context.read<TodoSearchCubit>().state.searchTerm
            );
          }
        ),
        BlocListener<TodoFilterCubit, TodoFilterState>(
          listener: (context, state) {
            context.read<FilteredTodosCubit>().setFilteredTodos(
              state.filter,
              context.read<TodoListCubit>().state.todos,
              context.read<TodoSearchCubit>().state.searchTerm
            );
          }
        ),
        BlocListener<TodoSearchCubit, TodoSearchState>(
          listener: (context, state) {
            context.read<FilteredTodosCubit>().setFilteredTodos(
              context.read<TodoFilterCubit>().state.filter,
              context.read<TodoListCubit>().state.todos,
              state.searchTerm
            );
          }
        )
      ],
      child: ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
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
          itemCount: todos.length),
    );
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
