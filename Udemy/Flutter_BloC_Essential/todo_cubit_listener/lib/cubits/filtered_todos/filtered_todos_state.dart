part of 'filtered_todos_cubit.dart';

class FilteredTodosState extends Equatable {
  final List<Todo> filteredTodos;
  FilteredTodosState({
    required this.filteredTodos,
  });

  factory FilteredTodosState.initial() => FilteredTodosState(filteredTodos: []);

  @override
  List<Object> get props => [filteredTodos];

  @override
  String toString() => 'FilteredTodoState(filteredTodos: $filteredTodos)';

  FilteredTodosState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}
