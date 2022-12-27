import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather_check/weather/bloc/weather_state.dart';
import 'package:weather_check/weather/models/models.dart';
import 'package:weather_repository/weather_repository.dart'
    show WeatherRepository;

abstract class WeatherEvent {}

class WeatherSearchEvent extends WeatherEvent {}

class WeatherRefreshEvent extends WeatherEvent {}

class WeatherBloc extends HydratedBloc<WeatherEvent, WeatherState> {
  WeatherBloc(this._weatherRepository) : super(const WeatherState()) {
    on<WeatherSearchEvent>((event, emit) async {
      emit(state.copyWith(status: WeatherStatus.loading));

      try {
        final weather = Weather.fromRepository(
            await _weatherRepository.getWeather(location: _location));

        emit(state.copyWith(status: WeatherStatus.success, weather: weather));
      } on Exception {
        emit(state.copyWith(status: WeatherStatus.failure));
      }
    });

    on<WeatherRefreshEvent>((event, emit) async {
      if (!state.status.isSuccess) return;
      if (state.weather == Weather.empty) return;

      emit(state.copyWith(status: WeatherStatus.loading));

      try {
        final weather = Weather.fromRepository(await _weatherRepository
            .getWeather(location: state.weather.location.name));

        emit(state.copyWith(status: WeatherStatus.success, weather: weather));
      } on Exception {
        emit(state);
      }
    });
  }

  void fetchWeather(String? location) {
    if (location == null || location.isEmpty) return;

    _location = location;
    add(WeatherSearchEvent());
  }

  final WeatherRepository _weatherRepository;
  String _location = '';

  @override
  WeatherState fromJson(Map<String, dynamic> json) {
    return WeatherState.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(WeatherState state) {
    return state.toJson();
  }
}
