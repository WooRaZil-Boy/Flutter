import 'package:open_weather_cubit/exceptions/weather_exception.dart';
import 'package:open_weather_cubit/models/custom_error.dart';
import 'package:open_weather_cubit/models/direct_geocoding.dart';
import 'package:open_weather_cubit/models/weather.dart';
import 'package:open_weather_cubit/services/weather_api_services.dart';

// 현재 openWheather 구조상 도시명 검색 -> lat, lon 반환 -> 반환된 lat, lon으로 날시 정보 검색의 2번 API 호출이 필요하다.
// 하지만 내부의 이런 구조를 따로 알 필요는 없기에 Repository에서 로직을 구현해 반환환다.
class WeatherRepository {
  final WeatherApiServices weatherApiServices;

  WeatherRepository({
    required this.weatherApiServices,
  });

  Future<Weather> fetchWeather(String city) async {
    try {
      final DirectGeocoding directGeocoding = await weatherApiServices.getDirectGeocoding(city);
      print('directGeocoding: $directGeocoding');

      final Weather tempWeather = await weatherApiServices.getWeather(directGeocoding);

      // API response로 반환된 도시명이 더 정확할 수 있지만, 일일히 검증을 할 수 없기 때문에 이전 값을 그대로 사용한다.
      final Weather weather = tempWeather.copyWith(
        name: directGeocoding.name,
        country: directGeocoding.country
      );

      print('weather: $weather');

      return weather;
    } on WeatherException catch (e) {
      // WeatherException 인 경우
      throw CustomError(errMsg: e.message);
    } catch (e) {
      // 일반 Exception 인 경우
      throw CustomError(errMsg: e.toString());
    }
  }
}
