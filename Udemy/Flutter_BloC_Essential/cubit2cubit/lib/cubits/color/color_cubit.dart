import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'color_state.dart';

class ColorCubit extends Cubit<ColorState> {
  ColorCubit() : super(ColorState.inital());

  // 모든 Cubit에는 state getter와 새로운 state를 stream에 내보내는 emit 함수가 있다.
  void changeColor() {
    if (state.color == Colors.red) {
      emit(state.copyWith(color: Colors.green));
    } else if (state.color == Colors.green) { 
      emit(state.copyWith(color: Colors.blue));
    } else if (state.color == Colors.blue) { 
      emit(state.copyWith(color: Colors.black));
    } else if (state.color == Colors.black) { 
      emit(state.copyWith(color: Colors.red));
    }
  }
}
