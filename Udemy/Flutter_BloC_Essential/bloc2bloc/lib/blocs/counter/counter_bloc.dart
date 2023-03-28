import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc2bloc/blocs/color/color_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int incrementSize = 1;
  final ColorBloc colorBloc;
  late final StreamSubscription colorSubscription;


  CounterBloc({
    required this.colorBloc
  }) : super(CounterState.initial()) {
    colorSubscription = colorBloc.stream.listen((ColorState colorState) {
      if (colorState.color == Colors.red) {
        incrementSize = 1;
      } else if (colorState.color == Colors.green) { 
        incrementSize = 10;
      } else if (colorState.color == Colors.blue) { 
        incrementSize = 100;
      } else if (colorState.color == Colors.black) { 
        incrementSize = -100;
        // BloC에서는 직접적으로 state를 emit 해서는 안 되고, eventHandler 내에서 새로운 state를 emit 해야 한다.
        add(ChangeCounterEvent());
      }
    });

    on<ChangeCounterEvent>((event, emit) {
      emit(state.copyWith(counter: state.counter + incrementSize));
    });
  }

  @override
  Future<void> close() {
    colorSubscription.cancel();

    return super.close();
  }
}
