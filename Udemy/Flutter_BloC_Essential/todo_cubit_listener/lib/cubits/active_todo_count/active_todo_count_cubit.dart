import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  // stream 사용하지 않고 listener를 사용하기 때문에 todoListCubit, StreamSubscription이 불필요하다.
  final int initialActiveTodoCount;
  
  ActiveTodoCountCubit({
    required this.initialActiveTodoCount,
  }) : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount));

  // 이전과 달리 todoListCubit을 더 이상 listen하지 않기 때문에 현재 몇 개가 active 인지를 외부에서 주어져야 한다.
  void calculateActiveTodoCount(int activeTodoCount) {
    emit(state.copyWith(activeTodoCount: activeTodoCount));
  }
}
