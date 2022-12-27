import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_meteo_api/open_meteo_api.dart';

class WeatherRequestFailure implements Exception {}

class WeatherNotFoundFailure implements Exception {}

class OpenMeteoApiClient {
  OpenMeteoApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();
  final http.Client _httpClient;

  static const _baseUrlWeather = 'api.weatherapi.com';

  Future<Weather> getWeather({required location}) async {
    final weatherRequest = Uri.http(_baseUrlWeather, 'v1/forecast.json', {
      'key': '63a7ad0853774c31acc123024221212',
      'days': '5',
      'aqi': 'yes',
      'alerts': 'no',
      'hour': '-1',
      'q': location,
    });

    final weatherResponse = await _httpClient.get(weatherRequest);

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final bodyJson = json.decode(weatherResponse.body) as Map<String, dynamic>;

    if (!(bodyJson.containsKey('current') &&
        bodyJson.containsKey('forecast') && bodyJson.containsKey('location'))) {
      throw WeatherNotFoundFailure();
    }

    return Weather(
        location: Location.fromJson(bodyJson['location']),
        current: CurrentWeather.fromJson(bodyJson['current']),
        forecast0: ForecastWeather.fromJson(
            bodyJson['forecast']['forecastday'][0]),
        forecast1: ForecastWeather.fromJson(
            bodyJson['forecast']['forecastday'][1]),
        forecast2: ForecastWeather.fromJson(
            bodyJson['forecast']['forecastday'][2])
    );
  }
}
