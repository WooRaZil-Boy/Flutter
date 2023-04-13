import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/cubits/cubits.dart';
import 'package:todo_cubit/pages/todos_page/todos_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoFilterCubit>(
          create: (context) => TodoFilterCubit()
        ),
        BlocProvider<TodoSearchCubit>(
          create: (context) => TodoSearchCubit()
        ),
        BlocProvider<TodoListCubit>(
          create: (context) => TodoListCubit()
        ),
        // ActiveTodoCountCubit은 TodoListCubit이 필요하다.
        // 이미 TodoListCubit를 생성했기 때문에 of로 가져올 수 있다.
        BlocProvider<ActiveTodoCountCubit>(
          create: (context) => ActiveTodoCountCubit(
            // ActiveTodoCountCubit에서 listen 했지만, initial value를 읽지는 않는다. 따라서 초기값을 지정해 준다.
            initialActiveTodoCount: context.read<TodoListCubit>().state.todos.length,
            todoListCubit: BlocProvider.of<TodoListCubit>(context)
          )
        ),
        // 이미 필요한 cubit들을를 생성했기 때문에 of로 가져올 수 있다.
        // BlocProvider.of 대신, watch를 사용할 수도 있다.
        BlocProvider<FilteredTodosCubit>(
          create: (context) => FilteredTodosCubit(
            initialTodos: context.read<TodoListCubit>().state.todos,
            todoFilterCubit: BlocProvider.of<TodoFilterCubit>(context),
            todoSearchCubit: BlocProvider.of<TodoSearchCubit>(context),
            todoListCubit: BlocProvider.of<TodoListCubit>(context),
          ),
        )
      ],
      child: MaterialApp(
        title: 'TODO',
        debugShowCheckedModeBanner: false, 
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodosPage(),
      ),
    );
  }
}