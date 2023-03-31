// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'active_todo_count_bloc.dart';

abstract class ActiveTodoCountEvent extends Equatable {
  const ActiveTodoCountEvent();

  @override
  List<Object> get props => [];
}

// 할일(todo) 목록에서 active 인것을 찾는다.
class CalculateActiveTodoCountEvent extends ActiveTodoCountEvent {
  final int activeTodoCount;

  CalculateActiveTodoCountEvent({
    required this.activeTodoCount,
  });

  @override
  String toString() => 'CalculateActiveTodoCountEvent(activeTodoCount: $activeTodoCount)';

  @override
  List<Object> get props => [activeTodoCount];
}
