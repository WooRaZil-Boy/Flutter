part of 'todo_filter_cubit.dart';

// enum에 비해 class로 관리하는 것이 장점이 더 많다. 
// Equatable을 상속하면, 같은 State에 대한 반복 동작을 막을 수 있다.
class TodoFilterState extends Equatable {
  final Filter filter;
  TodoFilterState({
    required this.filter,
  });

  // 이렇게 factory 생성자를 만들어 두면, 시간이 지나더라도, 초기값을 금방 알수 있다.
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
