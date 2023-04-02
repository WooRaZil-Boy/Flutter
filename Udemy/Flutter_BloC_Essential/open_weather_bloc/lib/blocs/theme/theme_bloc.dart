import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_weather_bloc/blocs/weather/weather_bloc.dart';
import 'package:open_weather_bloc/constants/constants.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  // weather의 변화가 있을 때마다 theme을 새로 설정해야 하기 때문에 weatherBloc을 listen해야 한다.
  late final StreamSubscription weatherSubscription;
  final WeatherBloc weatherBloc;

  ThemeBloc({
    required this.weatherBloc,
  }) : super(ThemeState.initial()) {
      weatherSubscription = weatherBloc.stream.listen((WeatherState weatherState) {
        
      if (weatherState.weather.temp > kWarmOrNot) {
        add(ChangeThemeEvent(appTheme: AppTheme.light));
      } else {
        add(ChangeThemeEvent(appTheme: AppTheme.dark));
      }
    });

    on<ChangeThemeEvent>((event, emit) {
      emit(state.copyWith(appTheme: event.appTheme));
    });
  }

  @override
  Future<void> close() {
    weatherSubscription.cancel();
    return super.close();
  }
}
