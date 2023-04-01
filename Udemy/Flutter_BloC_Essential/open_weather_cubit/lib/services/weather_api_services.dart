import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_cubit/constants/constants.dart';
import 'package:open_weather_cubit/exceptions/weather_exception.dart';
import 'package:open_weather_cubit/models/direct_geocoding.dart';
import 'package:open_weather_cubit/models/weather.dart';
import 'package:open_weather_cubit/services/http_error_handler.dart';

class WeatherApiServices {
  // http connection을 계속 열어두는 방식으로 사용한다.
  final http.Client httpClient;

  WeatherApiServices({
    required this.httpClient,
  });

  Future<DirectGeocoding> getDirectGeocoding(String city) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: 'geo/1.0/direct',
      queryParameters: {
        'q': city,
        'limit': kLimit,
        'appid': dotenv.env['APPID'],
      }
    );

    try {
      final http.Response response = await httpClient.get(uri);

      if (response.statusCode != 200) {
        // dart에서는 문자열도 throw 가능하다.
        throw httpErrorHandler(response);
      }

      final responseBody = json.decode(response.body);

      if (responseBody.isEmpty) {
        throw WeatherException('Cannot get the location of $city');
      }

      final directGeocoding = DirectGeocoding.fromJson(responseBody);
      return directGeocoding;
    } catch (e) {
      // 별다른 에러 처리를 하지 않고, 호출한 쪽에 해당 에러를 다시 던진다.
      rethrow;
    }
  }

  Future<Weather> getWeather(DirectGeocoding directGeocoding) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: 'data/2.5/weather',
      queryParameters: {
        'lat': '${directGeocoding.lat}',
        'lon': '${directGeocoding.lon}',
        'units': kUnit,
        'appid': dotenv.env['APPID'],
      }
    );

    try {
      final http.Response response = await httpClient.get(uri);

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final weatherJson = json.decode(response.body);

      final Weather weather = Weather.fromJson(weatherJson);
      return weather;
    } catch (e) {
      rethrow;
    }
  }
} 
