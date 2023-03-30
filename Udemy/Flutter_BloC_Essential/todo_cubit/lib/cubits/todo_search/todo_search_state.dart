part of 'todo_search_cubit.dart';

// 단순히 String으로 만들수도 있지만, 일관성을 위해 class로 하는 것이 좋다. 또한 type 충돌을 피할 수도 있다.
// BlocProvider는 type을 기준으로 위젯 트리에서 객체를 찾는데, type이 같으면 더 멀리 떨어진 cubit에 접근하기 어려워 진다.
class TodoSearchState extends Equatable {
  final String searchTerm;

  TodoSearchState({
    required this.searchTerm,
  });

  factory TodoSearchState.initial() => TodoSearchState(searchTerm: '');

  @override
  List<Object> get props => [searchTerm];

  @override
  String toString() => 'TodoSearchState(searchTerm: $searchTerm)';

  TodoSearchState copyWith({
    String? searchTerm,
  }) {
    return TodoSearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}
