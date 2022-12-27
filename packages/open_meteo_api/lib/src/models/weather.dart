import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Condition {
  const Condition({required this.text, required this.icon});
  final String text;
  final String icon;

  factory Condition.fromJson(Map<String, dynamic> json) =>
      _$ConditionFromJson(json);
}

@JsonSerializable()
class Astro {
  const Astro({required this.sunrise, required this.sunset});
  final String sunrise;
  final String sunset;

  factory Astro.fromJson(Map<String, dynamic> json) => _$AstroFromJson(json);
}

@JsonSerializable()
class Aqi {
  const Aqi({required this.usEpaIndex});
  @JsonKey(name: 'us-epa-index')
  final int usEpaIndex;

  factory Aqi.fromJson(Map<String, dynamic> json) => _$AqiFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CurrentWeather {
  const CurrentWeather(
      {required this.temperature,
      required this.wind,
      required this.humidity,
      required this.cloud,
      required this.condition,
      required this.airQuality});

  @JsonKey(name: 'temp_c')
  final double temperature;
  @JsonKey(name: 'wind_kph')
  final double wind;
  final double humidity;
  final double cloud;
  final Condition condition;
  @JsonKey(name: 'air_quality')
  final Aqi airQuality;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class Day {
  const Day({
    required this.temperature,
    required this.wind,
    required this.humidity,
    required this.condition,
  });

  @JsonKey(name: 'avgtemp_c')
  final double temperature;
  @JsonKey(name: 'maxwind_kph')
  final double wind;
  @JsonKey(name: 'avghumidity')
  final double humidity;

  final Condition condition;

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class ForecastWeather {
  const ForecastWeather(
      {required this.date, required this.day, required this.astro});
  final String date;
  final Day day;
  final Astro astro;

  factory ForecastWeather.fromJson(Map<String, dynamic> json) =>
      _$ForecastWeatherFromJson(json);
}

@JsonSerializable()
class Location {
  const Location({required this.name});
  final String name;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

class Weather {
  const Weather(
      {required this.location,
      required this.current,
      required this.forecast0,
      required this.forecast1,
      required this.forecast2});
  final Location location;
  final CurrentWeather current;
  final ForecastWeather forecast0;
  final ForecastWeather forecast1;
  final ForecastWeather forecast2;
}
