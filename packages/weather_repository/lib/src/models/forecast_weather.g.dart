// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastWeather _$ForecastWeatherFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ForecastWeather',
      json,
      ($checkedConvert) {
        final val = ForecastWeather(
          temperature:
              $checkedConvert('temperature', (v) => (v as num).toDouble()),
          wind: $checkedConvert('wind', (v) => (v as num).toDouble()),
          humidity: $checkedConvert('humidity', (v) => (v as num).toDouble()),
          condition: $checkedConvert('condition', (v) => v as String),
          conditionImage:
              $checkedConvert('condition_image', (v) => v as String),
          date: $checkedConvert('date', (v) => v as String),
          sunrise: $checkedConvert('sunrise', (v) => v as String),
          sunset: $checkedConvert('sunset', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'conditionImage': 'condition_image'},
    );

Map<String, dynamic> _$ForecastWeatherToJson(ForecastWeather instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'wind': instance.wind,
      'humidity': instance.humidity,
      'condition': instance.condition,
      'condition_image': instance.conditionImage,
      'date': instance.date,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };
