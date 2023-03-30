// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo_cubit/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_cubit/models/todo_model.dart';

part 'active_todo_count_state.dart';

// 완료된 todo의 수를 관리한다. 토글, 삭제 시 값이 변하기 때문에 state로 관리해야 한다.
class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  // 이전에 TodoListState의 초기값으로 세 개의 Todo items를 줬기 때문에 
  // ActiveTodoCountState.initial() 이 엄밀하게는 정확한 초기 값이 아니다.
  // ActiveTodoCountState를 계산하려면, TodoList 자체를 inspect해야 한다(TodoList 항목들의 completed가 t/f 인지 확인해야 한다).
  // 즉, ActiveTodoCountCubit은 TodoListState의 값이 필요하다. 따라서 ActiveTodoCountCubit은 TodoListCubit을 listen 해야 한다.
  late final StreamSubscription todoListSubscription;
  final TodoListCubit todoListCubit;
  
  ActiveTodoCountCubit({
    required this.todoListCubit,
  }) : super(ActiveTodoCountState.initial()) {
    // listen은 등록 시점 이후, 즉 다음 cubit stream의 값을 읽는다.
    todoListSubscription = todoListCubit.stream.listen((TodoListState todoListState) {
      print('todoListState: $todoListState');

      final int currentActiveTodoCount = todoListState.todos
        .where((Todo todo) => !todo.completed)
        .toList()
        .length;

        emit(state.copyWith(activeTodoCount: currentActiveTodoCount));
    });
  }

  @override
  Future<void> close() {
    todoListSubscription.cancel();
    return super.close();
  }
}
