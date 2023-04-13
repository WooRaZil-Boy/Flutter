part of 'counter_bloc.dart';

// BloC와 Cubit는 state를 다루는 방법이 다를 뿐, state 자체가 다르진 않다.
class CounterState extends Equatable {
  final int counter;
  
  CounterState({
    required this.counter,
  });

  factory CounterState.initial() {
    return CounterState(counter: 0);
  }

  @override
  List<Object> get props => [counter];

  @override
  String toString() => 'CounterState(counter: $counter)';

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }
}