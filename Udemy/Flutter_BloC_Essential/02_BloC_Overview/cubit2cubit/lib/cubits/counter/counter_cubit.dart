import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cubit2cubit/cubits/color/color_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'counter_state.dart';

// 다른 BloC이나 Cubit에 의존해야 할 때, Provider에서는 ProxyProvider를 사용했다.
// 새로운 State가 생성되면, stream에 넣는다. == Bloc이나 Cubit에서 해당 stream을 listen할 수 있다.
// 따라서 필요한 state를 구독한 후, 처리한 후 새로운 state를 내보내면 된다.
// 여기서는 counter cubit이 color cubit에 의존하게 된다.
class CounterCubit extends Cubit<CounterState> {
  int incrementSize = 1;
  final ColorCubit colorCubit;
  late final StreamSubscription colorSubscription;

  CounterCubit({
    required this.colorCubit
  }) : super(CounterState.initial()) {
    // colorCubit의 변화를 받아 처리한다.
    // 값이 변할때 마다 받아오지만, initial state는 반영되지 않는다.
    colorSubscription = colorCubit.stream.listen((ColorState colorState) {
      if (colorState.color == Colors.red) {
        incrementSize = 1;
      } else if (colorState.color == Colors.green) { 
        incrementSize = 10;
      } else if (colorState.color == Colors.blue) { 
        incrementSize = 100;
      } else if (colorState.color == Colors.black) { 
        emit(state.copyWith(counter: state.counter - 100));
        incrementSize = -100;
      }
    });
  }

  void changeCounter() {
    emit(state.copyWith(counter: state.counter + incrementSize));
  }

  @override
  Future<void> close() {
    // 자동으로 해제되지 않기 때문에 메모리 누수가 일어날 수 있다.직접 release 해야 한다.
    colorSubscription.cancel();

    return super.close();
  }
}
