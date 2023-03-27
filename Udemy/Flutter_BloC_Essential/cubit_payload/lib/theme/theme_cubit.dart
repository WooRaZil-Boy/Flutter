import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

// cubit에는 Event가 없다.
// BloC의 경우, Event에 추가적인 데이터가 필요하면, Event 클래스의 payload로 데이터를 넘겨주는데
// Cubit은 function의 arguments로 넘겨주면 된다.
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  void changeTheme(int randInt) {
    if (randInt % 2 == 0) {
        emit(state.copyWith(appTheme: AppTheme.light));
      } else {
        emit(state.copyWith(appTheme: AppTheme.dark));
      }
  }
}
