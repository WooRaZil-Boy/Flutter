part of 'todo_filter_bloc.dart';

class TodoFilterState extends Equatable {
  final Filter filter;
  TodoFilterState({
    required this.filter,
  });

  factory TodoFilterState.initial() => TodoFilterState(filter: Filter.all);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'TodoFilterState(filter: $filter)';

  TodoFilterState copyWith({
    Filter? filter,
  }) {
    return TodoFilterState(
      filter: filter ?? this.filter,
    );
  }
}