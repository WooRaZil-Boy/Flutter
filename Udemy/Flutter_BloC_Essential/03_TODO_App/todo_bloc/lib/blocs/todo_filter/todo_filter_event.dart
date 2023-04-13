// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_filter_bloc.dart';

// Cubit에서는 Event를 따로 다루지 않고, 함수로 처리한다.
abstract class TodoFilterEvent extends Equatable {
  const TodoFilterEvent();

  @override
  List<Object> get props => [];
}

// Filter와 관련된 Event를 정의하고, TodoFilterEvent를 구현한다.
// ChangeFilterEvent는 All, Active, Completed 를 누를 때 발생하고 그 결과로 State가 변경되어야 한다.
// 따라서 TextButton을 탭해서 ChangeFilterEvent가 발생할 때, 해당 이벤트에서 원하는 결과를 얻기위한 값이 주어줘야 한다.
// 여기서는 해당 값이 변경할 필터가 된다.
class ChangeFilterEvent extends TodoFilterEvent {
  final Filter newFilter;
  
  ChangeFilterEvent({
    required this.newFilter,
  });

  @override
  String toString() => 'ChangeFilterEvent(nerFilter: $newFilter)';

  @override
  List<Object> get props => [newFilter];
}
