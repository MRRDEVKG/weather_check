import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forecast_weather.g.dart';

@JsonSerializable(explicitToJson: true)
class ForecastWeather extends Equatable {
  const ForecastWeather(
      {required this.temperature,
      required this.wind,
      required this.humidity,
      required this.condition,
      required this.conditionImage,
      required this.date,
      required this.sunrise,
      required this.sunset});

  final double temperature;
  final double wind;
  final double humidity;
  final String condition;
  final String conditionImage;
  final String date;
  final String sunrise;
  final String sunset;

  factory ForecastWeather.fromJson(Map<String, dynamic> json) =>
      _$ForecastWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastWeatherToJson(this);

  @override
  List<Object?> get props => [
        temperature,
        wind,
        humidity,
        condition,
        conditionImage,
        date,
        sunrise,
        sunset
      ];
}
