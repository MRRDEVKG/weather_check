// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentWeather _$CurrentWeatherFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CurrentWeather',
      json,
      ($checkedConvert) {
        final val = CurrentWeather(
          temperature:
              $checkedConvert('temperature', (v) => (v as num).toDouble()),
          wind: $checkedConvert('wind', (v) => (v as num).toDouble()),
          humidity: $checkedConvert('humidity', (v) => (v as num).toDouble()),
          cloud: $checkedConvert('cloud', (v) => (v as num).toDouble()),
          condition: $checkedConvert('condition', (v) => v as String),
          conditionImage:
              $checkedConvert('condition_image', (v) => v as String),
          aqi: $checkedConvert('aqi', (v) => v as int),
          aqiCondition: $checkedConvert('aqi_condition', (v) => v as String),
          date: $checkedConvert('date', (v) => v as String),
          sunrise: $checkedConvert('sunrise', (v) => v as String),
          sunset: $checkedConvert('sunset', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'conditionImage': 'condition_image',
        'aqiCondition': 'aqi_condition'
      },
    );

Map<String, dynamic> _$CurrentWeatherToJson(CurrentWeather instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'wind': instance.wind,
      'humidity': instance.humidity,
      'cloud': instance.cloud,
      'condition': instance.condition,
      'condition_image': instance.conditionImage,
      'aqi': instance.aqi,
      'aqi_condition': instance.aqiCondition,
      'date': instance.date,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };
