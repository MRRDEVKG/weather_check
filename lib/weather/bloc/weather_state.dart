import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_check/weather/models/models.dart';

part 'weather_state.g.dart';

enum WeatherStatus { initial, loading, success, failure }


extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;
}

@JsonSerializable(explicitToJson: true)
class WeatherState extends Equatable {
  const WeatherState({this.status = WeatherStatus.initial, Weather? weather})
      : weather = weather ?? Weather.empty;

  final WeatherStatus status;
  final Weather weather;


  WeatherState copyWith({WeatherStatus? status, Weather? weather}) {
    return WeatherState(
        status: status ?? this.status, weather: weather ?? this.weather);
  }

  factory WeatherState.fromJson(Map<String, dynamic> json) => _$WeatherStateFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherStateToJson(this);

  @override
  List<Object?> get props => [status, weather];
}
