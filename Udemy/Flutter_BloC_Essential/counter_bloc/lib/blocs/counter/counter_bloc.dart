import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

// BloC은 cubit과 달리 state의 type 외에도 event의 type도 지정해야 한다.
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial()) {
    // emit은 eventHandler 내에서만 사용되어야 한다.
    // 하나의 event에 대한 eventHandler는 하나만 존재해야 한다.
    on<IncrementCounterEvent>((event, emit) {
      emit(state.copyWith(counter: state.counter + 1));
    });

    on<DecrementCounterEvent>(_decrementCounter);
  }

  // handler가 복잡해질 경우 아래와 같이 따로 메서드를 작성할 수 있다.
  void _decrementCounter(
    DecrementCounterEvent event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(counter: state.counter - 1));
  }
}
