
import 'package:equatable/equatable.dart';
import 'package:weather_repository/weather_repository.dart';

class Weather extends Equatable{
  const Weather({required this.location, required this.currentWeather, required this.forecastWeatherList});

  final Location location;
  final CurrentWeather currentWeather;
  final List<ForecastWeather> forecastWeatherList;

  @override
  List<Object?> get props => [location, currentWeather, forecastWeatherList];
}