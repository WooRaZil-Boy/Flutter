import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_weather_cubit_listener/constants/constants.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  // StreamSubscription을 사용하지 않으므로, 해당 스트림과 값을 가져와야 할 cubit이 없어도 된다.
  ThemeCubit() : super(ThemeState.initial());

  // 대신 외부에서 해당 값을 받아야 한다.
  void setTheme(double currentTemp) {
    if (currentTemp > kWarmOrNot) {
      emit(state.copyWith(appTheme: AppTheme.light));
    } else {
      emit(state.copyWith(appTheme: AppTheme.dark));
    }
  }
}
