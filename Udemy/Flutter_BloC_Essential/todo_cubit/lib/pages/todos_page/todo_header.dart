import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/cubits/cubits.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'TODO',
          style: TextStyle(fontSize: 40.0),
        ),
        // active한 todo에 따라 다시 리빌드가 되어야 하므로 해당 cubit을 위젯트리에 inject하고 가져와야 한다.
        // BlocBuilder나 watch를 쓸 수 있다.
        // Text(
        //   '0 items left',
        //   style: TextStyle(fontSize: 20.0, color: Colors.redAccent),
        // ),
        // BlocBuilder<ActiveTodoCountCubit, ActiveTodoCountState>(
        //   builder: (context, state) {
        //     return Text(
        //       '${state.activeTodoCount} items left',
        //       style: TextStyle(fontSize: 20.0, color: Colors.redAccent),
        //     );
        //   },
        // ),
        Text(
          '${context.watch<ActiveTodoCountCubit>().state.activeTodoCount} items left',
          style: TextStyle(fontSize: 20.0, color: Colors.redAccent),
        ),
      ],
    );
  }
}