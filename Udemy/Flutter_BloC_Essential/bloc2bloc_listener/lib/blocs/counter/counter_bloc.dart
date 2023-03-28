import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  // incrementSize를 외부에서 주입 받아야 한다.
  // Cubit에서는 incrementSize가 함수의 arguments로 주어졌다면, 
  // Cubit과 달리 BloC에서는 UI가 BloC에 요청을 해야할 때, Event를 사용한다. 이때 Event의 properties로 사용한다.
  int incrementSize = 1;

  CounterBloc() : super(CounterState.initial()) {
    on<ChangeCounterEvent>((event, emit) {
      emit(state.copyWith(counter: state.counter + event.incrementSize));
    });
  }
}
