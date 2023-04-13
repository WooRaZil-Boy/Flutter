import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_bloc/blocs/todo_filter/todo_filter_bloc.dart';
import 'package:todo_bloc/blocs/todo_list/todo_list_bloc.dart';
import 'package:todo_bloc/blocs/todo_search/todo_search_bloc.dart';
import 'package:todo_bloc/models/todo_model.dart';

part 'filtered_todos_event.dart';
part 'filtered_todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  late StreamSubscription todoFilterSubscription;
  late StreamSubscription todoSearchSubscription;
  late StreamSubscription todoListSubscription;
  final List<Todo> initialTodos;

  final TodoFilterBloc todoFilterBloc;
  final TodoSearchBloc todoSearchBloc;
  final TodoListBloc todoListBloc;

  FilteredTodosBloc({
    required this.initialTodos,
    required this.todoFilterBloc,
    required this.todoSearchBloc,
    required this.todoListBloc,
  }) : super(FilteredTodosState(filteredTodos: initialTodos)) {
    todoFilterSubscription = todoFilterBloc.stream.listen((TodoFilterState todoFilterState) {
      setFilteredTodos();
    });

    todoSearchSubscription = todoSearchBloc.stream.listen((TodoSearchState todoSearchState) {
      setFilteredTodos();
    });

    todoListSubscription = todoListBloc.stream.listen((TodoListState todoListState) {
      setFilteredTodos();
    });

    on<CalculateFilteredTodosEvent>((event, emit) {
      emit(state.copyWith(filteredTodos: event.filteredTodos));
    });
  }

  void setFilteredTodos() {
    List<Todo> _filteredTodos;

    switch (todoFilterBloc.state.filter) {
      case Filter.active:
        _filteredTodos = todoListBloc.state.todos
          .where((Todo todo) => !todo.completed)
          .toList();
        break;
      case Filter.completed:
          _filteredTodos = todoListBloc.state.todos
          .where((Todo todo) => todo.completed)
          .toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todoListBloc.state.todos;
    }

    if (todoSearchBloc.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
        .where((Todo todo) => todo.desc
          .toLowerCase()
          .contains(todoSearchBloc.state.searchTerm.toLowerCase())
        )
        .toList();
    }

    add(CalculateFilteredTodosEvent(filteredTodos: _filteredTodos));
  }

  @override
  Future<void> close() {
    todoFilterSubscription.cancel();
    todoSearchSubscription.cancel();
    todoListSubscription.cancel();

    return super.close();
  }
}
