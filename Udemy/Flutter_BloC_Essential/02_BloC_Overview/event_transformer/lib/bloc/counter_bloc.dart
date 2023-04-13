import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial()) {
    // on<IncrementCounterEvent>(
    //   _handleIncrementCounterEvent,
    //   transformer: sequential()
    // );

    // on<DecrementCounterEvent>(
    //   _handleDecrementCounterEvent,
    //   // droppable을 사용하면, 첫 이벤트를 사용하는 동안 들어오는 이벤트를 모두 drop 한다.
    //   // 따라서 decrement를 빠르게 3번 눌러도, 2초 안에 발생한 이벤트라면 처음 한 번만 유효하게 동작한다.
      
    //   // restartable을 사용하면, 새로운 이벤트가 들어오면 이전 이벤트를 cancel한다.
    //   // 따라서 decrement를 빠르게 계속 누르면 계속해서 이벤트가 cancel 되어 counter는 0에서 변하지 않다가, 
    //   // 탭을 멈췄을 때 마지막의 이벤트만 유효하게 동작한다.

    //   // sequential은 이벤트가 입력된 순서대로 순차 처리가 된다.
    //   // 하지만 해당 sequential은 local하다. 즉, increment, decrement를 순차적으로 눌러도 각 이벤트가 sequential하기 때문에
    //   // 해당 조건에서는 concurrent와 동일하게 동작한다.
    //   transformer: sequential()
    // );

    // 7.2 이전에는 의도한 대로 sequential를 작동하게 하려면 모든 이벤트를 catch할 수 있는 single bucket을 만들어야 했다.
    // IncrementCounter와 DecrementCounterEvent는 모두 EventCounterEvent의 subClass 이다.
    // increment, decrement를 순차적으로 누르면 여기서는 두 이벤트가 sequential이기 때문에 순차적으로 처리된다.
    on<CounterEvent>(
      (event, emit) async {
        if (event is IncrementCounterEvent) {
          await _handleIncrementCounterEvent(event, emit);
        } else if (event is DecrementCounterEvent) {
          await _handleDecrementCounterEvent(event, emit);
        }
      },
      transformer: sequential()
    );
  }

  // 비동기로 이벤트가 처리되기 때문에 increment가 4초, decrement가 2초 일때, increment, decrement를 차례대로 눌러도 -1이 된 후 0이 된다.
  Future<void> _handleIncrementCounterEvent(event, emit) async {
    await Future.delayed(Duration(seconds: 4));
    emit(state.copyWith(counter: state.counter + 1));
  }

  Future<void> _handleDecrementCounterEvent(event, emit) async {
    await Future.delayed(Duration(seconds: 2));
    emit(state.copyWith(counter: state.counter - 1));
  }
}

// 스트림은 다양한 방법으로 변환할 수 있다.
// 이벤트 처리 방식 : concurrent, sequential, droppable, restartable
// BloC는 기본적으로 concurrent. bloc_concurrency를 사용하여 처리 방식을 바꾸거나 이벤트를 변화 시킬수 있다.
// 이를 Event Transformation 이라고 하고 이를 구현하는 것이 Event Transformer이다.
// BloC는 BloC 별로 Event Transformer를 지정할 수 있고, 앱에 사용되는 모든 BloC에 대해 Event Transformer를 지정할 수도 있다.
// 특정 구역을 만들어 zone 별로 지정할 수도 있다.
