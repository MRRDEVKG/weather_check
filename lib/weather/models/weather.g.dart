// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Weather',
      json,
      ($checkedConvert) {
        final val = Weather(
          location: $checkedConvert(
              'location', (v) => Location.fromJson(v as Map<String, dynamic>)),
          currentWeather: $checkedConvert('current_weather',
              (v) => CurrentWeather.fromJson(v as Map<String, dynamic>)),
          forecastWeatherList: $checkedConvert(
              'forecast_weather_list',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      ForecastWeather.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'currentWeather': 'current_weather',
        'forecastWeatherList': 'forecast_weather_list'
      },
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'location': instance.location.toJson(),
      'current_weather': instance.currentWeather.toJson(),
      'forecast_weather_list':
          instance.forecastWeatherList.map((e) => e.toJson()).toList(),
    };
