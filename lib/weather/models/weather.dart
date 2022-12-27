import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_repository/weather_repository.dart' hide Weather;
import 'package:weather_repository/weather_repository.dart'
    as weather_repository;

part 'weather.g.dart';

@JsonSerializable(explicitToJson: true)
class Weather extends Equatable {
  const Weather(
      {required this.location,
      required this.currentWeather,
      required this.forecastWeatherList});

  static const empty = Weather(
      location: Location(name: '___'),
      currentWeather: CurrentWeather(
          temperature: 0,
          wind: 0,
          humidity: 0,
          cloud: 0,
          condition: 'Unknown',
          conditionImage: 'Unknown',
          aqi: 0,
          aqiCondition: 'Unknown',
          date: '____-__-__',
          sunrise: '__:__',
          sunset: '__:__'),
      forecastWeatherList: []);

  final Location location;
  final CurrentWeather currentWeather;
  final List<ForecastWeather> forecastWeatherList;

  factory Weather.fromRepository(weather_repository.Weather weather) => Weather(
      location: weather.location,
      currentWeather: weather.currentWeather,
      forecastWeatherList: weather.forecastWeatherList);

  Weather copyWith(
          {Location? location,
          CurrentWeather? currentWeather,
          List<ForecastWeather>? forecastWeatherList}) =>
      Weather(
          location: location ?? this.location,
          currentWeather: currentWeather ?? this.currentWeather,
          forecastWeatherList: forecastWeatherList ?? this.forecastWeatherList);

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @override
  List<Object?> get props => [location, currentWeather, forecastWeatherList];
}
