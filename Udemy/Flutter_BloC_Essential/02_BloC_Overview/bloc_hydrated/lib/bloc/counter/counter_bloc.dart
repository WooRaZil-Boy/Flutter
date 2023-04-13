import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> with HydratedMixin {
  CounterBloc() : super(CounterState.initial()) {
    on<IncrementCounterEvent>((event, emit) {
      emit(state.copyWith(counter: state.counter + 1));
    });

    on<DecrementCounterEvent>((event, emit) {
      emit(state.copyWith(counter: state.counter - 1));
    });
  }
  
  // 저장된 state가 필요할 때마다 호출이 된다. json 형태의 데이터를 가지고 와 다시 state로 변경시켜 반환한다.
  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    print('Counter from storage: $json');
    final counterState = CounterState.fromJson(json);
    print('CounterState: $counterState');
    return counterState;
  }
  
  // 새로운 state가 생성될 때마다 호출이 된다. hydratedBloc이 json 형태로 hive에 저장한다.
  @override
  Map<String, dynamic>? toJson(CounterState state) {
    print('CounterState to storage: $state');
    final counterJson = state.toJson();
    print('CounterJson: $counterJson');
    return counterJson;
  }
}
