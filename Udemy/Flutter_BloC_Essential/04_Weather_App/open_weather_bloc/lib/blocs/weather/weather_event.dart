part of 'weather_bloc.dart';

// Cubit에서는 Event를 따로 다루지 않는다.
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherEvent extends WeatherEvent {
  // 어떤 city를 검색했는지 알아야 하기 때문에 String이 필요하다.
  final String city;

  FetchWeatherEvent({
    required this.city,
  });
}