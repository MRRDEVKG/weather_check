// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Condition _$ConditionFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Condition',
      json,
      ($checkedConvert) {
        final val = Condition(
          text: $checkedConvert('text', (v) => v as String),
          icon: $checkedConvert('icon', (v) => v as String),
        );
        return val;
      },
    );

Astro _$AstroFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Astro',
      json,
      ($checkedConvert) {
        final val = Astro(
          sunrise: $checkedConvert('sunrise', (v) => v as String),
          sunset: $checkedConvert('sunset', (v) => v as String),
        );
        return val;
      },
    );

Aqi _$AqiFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Aqi',
      json,
      ($checkedConvert) {
        final val = Aqi(
          usEpaIndex: $checkedConvert('us-epa-index', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {'usEpaIndex': 'us-epa-index'},
    );

CurrentWeather _$CurrentWeatherFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CurrentWeather',
      json,
      ($checkedConvert) {
        final val = CurrentWeather(
          temperature: $checkedConvert('temp_c', (v) => (v as num).toDouble()),
          wind: $checkedConvert('wind_kph', (v) => (v as num).toDouble()),
          humidity: $checkedConvert('humidity', (v) => (v as num).toDouble()),
          cloud: $checkedConvert('cloud', (v) => (v as num).toDouble()),
          condition: $checkedConvert('condition',
              (v) => Condition.fromJson(v as Map<String, dynamic>)),
          airQuality: $checkedConvert(
              'air_quality', (v) => Aqi.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'temperature': 'temp_c',
        'wind': 'wind_kph',
        'airQuality': 'air_quality'
      },
    );

Day _$DayFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Day',
      json,
      ($checkedConvert) {
        final val = Day(
          temperature:
              $checkedConvert('avgtemp_c', (v) => (v as num).toDouble()),
          wind: $checkedConvert('maxwind_kph', (v) => (v as num).toDouble()),
          humidity:
              $checkedConvert('avghumidity', (v) => (v as num).toDouble()),
          condition: $checkedConvert('condition',
              (v) => Condition.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'temperature': 'avgtemp_c',
        'wind': 'maxwind_kph',
        'humidity': 'avghumidity'
      },
    );

ForecastWeather _$ForecastWeatherFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ForecastWeather',
      json,
      ($checkedConvert) {
        final val = ForecastWeather(
          date: $checkedConvert('date', (v) => v as String),
          day: $checkedConvert(
              'day', (v) => Day.fromJson(v as Map<String, dynamic>)),
          astro: $checkedConvert(
              'astro', (v) => Astro.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Location _$LocationFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Location',
      json,
      ($checkedConvert) {
        final val = Location(
          name: $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
    );
