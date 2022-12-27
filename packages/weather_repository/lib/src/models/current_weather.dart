import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current_weather.g.dart';

const Map<int, String> aqiCondition = {0: 'Unknown', 1: 'Good', 2: 'Moderate', 3: 'Unhealthy for sensitive group', 4: 'Unhealthy', 5: 'Very Unhealthy', 6: 'Hazardous'};

@JsonSerializable(explicitToJson: true)
class CurrentWeather extends Equatable {
  const CurrentWeather(
      {required this.temperature,
      required this.wind,
      required this.humidity,
      required this.cloud,
      required this.condition,
      required this.conditionImage,
      required this.aqi,
      required this.aqiCondition,
      required this.date,
      required this.sunrise,
      required this.sunset});

  final double temperature;
  final double wind;
  final double humidity;
  final double cloud;
  final String condition;
  final String conditionImage;
  final int aqi;
  final String aqiCondition;
  final String date;
  final String sunrise;
  final String sunset;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => _$CurrentWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherToJson(this);

  @override
  List<Object?> get props => [
        temperature,
        wind,
        humidity,
        cloud,
        condition,
        conditionImage,
        aqi,
        aqiCondition,
        date,
        sunrise,
        sunset
      ];
}
