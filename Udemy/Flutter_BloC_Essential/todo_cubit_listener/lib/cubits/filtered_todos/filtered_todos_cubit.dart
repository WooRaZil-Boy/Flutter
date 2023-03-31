import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_cubit_listener/models/todo_model.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  // stream 사용하지 않고 listener를 사용하기 때문에 cubit과 StreamSubscription이 불필요하다.
  final List<Todo> initialTodos;

  FilteredTodosCubit({
    required this.initialTodos,
  }) : super(FilteredTodosState(filteredTodos: initialTodos));

  // setFilteredTodos 함수는 외부에서 호출이 되고, 계산에 필요한 값들도 외부에서 제공이 되어야 한다.
  void setFilteredTodos(
    Filter filter, 
    List<Todo> todos,
    String searchTerm
  ) {
    List<Todo> _filteredTodos;

    switch (filter) {
      case Filter.active:
        _filteredTodos = todos
          .where((Todo todo) => !todo.completed)
          .toList();
        break;
      case Filter.completed:
          _filteredTodos = todos
          .where((Todo todo) => todo.completed)
          .toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todos;
    }

    if (searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
        .where((Todo todo) => todo.desc
          .toLowerCase()
          .contains(searchTerm.toLowerCase())
        )
        .toList();
    }

    emit(state.copyWith(filteredTodos: _filteredTodos));
  }
}
