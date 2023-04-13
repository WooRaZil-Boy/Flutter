import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState.initial());

  // 외부에서 호출할 수 있는 메서드
  void increment() {
    emit(state.copyWith(counter: state.counter + 1));
  }

  void decrement() {
    emit(state.copyWith(counter: state.counter - 1));
  }
}

// 모든 cubit에는 state와 emit 함수가 있다.
// counter 값에 접근하려면, state.counter
// 새로운 counter state는
// emit(state.copyWith(counter: state.counter + 1)) 로 만들 수 있다.
// copyWith를 사용하면, 인수로 받은 값 외에는 모두 이전 상태의 값이 들어간다.
// copyWith는 기존의 state를 변경하지 않고, 매번 새로운 state를 생성한다.