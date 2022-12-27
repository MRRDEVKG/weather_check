import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_check/weather/bloc/weather_bloc.dart';
import 'package:weather_check/weather/bloc/weather_state.dart';
import 'package:weather_check/weather/models/models.dart';
import 'package:weather_repository/weather_repository.dart'
    as weather_repository;
import 'package:mocktail/mocktail.dart';
import '../../helpers/hydrated_bloc.dart';

const location = weather_repository.Location(name: 'Bishkek');
const currentWeather = weather_repository.CurrentWeather(
    temperature: 0,
    wind: 0,
    humidity: 0,
    cloud: 0,
    condition: 'Unknown',
    conditionImage: 'Unknown',
    aqi: 0,
    aqiCondition: 'Unknown',
    date: '____-__-__',
    sunrise: '__:__',
    sunset: '__:__');
const forecastWeatherList = <weather_repository.ForecastWeather>[];

class MockWeatherRepository extends Mock
    implements weather_repository.WeatherRepository {}

class MockWeather extends Mock implements weather_repository.Weather {}

void main() {
  initHydratedStorage();

  group('WeatherBloc', () {
    late MockWeatherRepository weatherRepository;
    late MockWeather weather;
    late WeatherBloc weatherBloc;

    setUp(() {
      weatherRepository = MockWeatherRepository();
      weather = MockWeather();
      when(() => weather.location).thenReturn(location);
      when(() => weather.currentWeather).thenReturn(currentWeather);
      when(() => weather.forecastWeatherList).thenReturn(forecastWeatherList);
      when(() => weatherRepository.getWeather(location: 'Bishkek'))
          .thenAnswer((_) async => weather);
      weatherBloc = WeatherBloc(weatherRepository);
    });

    test('initial state is correct', () {
      final weatherBloc = WeatherBloc(weatherRepository);
      expect(weatherBloc.state, const WeatherState());
    });

    group('toJson/fromJson', () {
      test(
          'work properly',
          () => expect(
              weatherBloc.fromJson(weatherBloc.toJson(weatherBloc.state)),
              weatherBloc.state));
    });

    group('fetchWeather', () {
      blocTest('emits nothing when location is null',
          build: () => weatherBloc,
          act: (bloc) => bloc.fetchWeather,
          expect: () => []);

      blocTest('emits nothing when location is empty',
          build: () => weatherBloc,
          act: (bloc) => bloc.fetchWeather(''),
          expect: () => []);

      blocTest('calls getWeather at least one time',
          build: () => weatherBloc,
          act: (bloc) => bloc.fetchWeather('Bishkek'),
          verify: (_) {
            verify(() => weatherRepository.getWeather(location: 'Bishkek'))
                .called(1);
          });

      blocTest('calls fetchWeather with correct location',
          build: () => weatherBloc,
          act: (bloc) => bloc.fetchWeather('Bishkek'),
          wait: const Duration(seconds: 2),
          expect: () => [
                isA<WeatherState>()
                    .having((ws) => ws.status, 'status', WeatherStatus.loading),
                isA<WeatherState>()
                    .having((ws) => ws.status, 'status', WeatherStatus.success),
              ]);

      blocTest('calls fetchWeather with correct location',
          build: () => weatherBloc,
          act: (bloc) => bloc.fetchWeather('Bishkek'),
          wait: const Duration(seconds: 2),
          skip: 1,
          expect: () => [
                const WeatherState(
                    status: WeatherStatus.success,
                    weather: Weather(
                        location: location,
                        currentWeather: currentWeather,
                        forecastWeatherList: forecastWeatherList)),
              ]);

      blocTest('emits [loading, failure] when getWeather throws',
          build: () => weatherBloc,
          setUp: () =>
              when(() => weatherRepository.getWeather(location: 'Bishkek'))
                  .thenThrow(Exception('oops')),
          act: (bloc) => bloc.fetchWeather('Bishkek'),
          expect: () => const <WeatherState>[
                WeatherState(status: WeatherStatus.loading),
                WeatherState(status: WeatherStatus.failure)
              ]);
    });

    group('refreshWeather', () {
      blocTest('emits nothing when status is not success',
          build: () => weatherBloc,
          act: (bloc) => bloc.add(WeatherRefreshEvent()),
          expect: () => []);

      blocTest(
        'emits nothing when location is null',
        build: () => weatherBloc,
        seed: () => const WeatherState(status: WeatherStatus.success),
        act: (bloc) => bloc.add(WeatherRefreshEvent()),
        expect: () => <WeatherState>[],
        verify: (_) =>
            verifyNever(() => weatherRepository.getWeather(location: '___')),
      );

      blocTest(
        'invokes getWeather with correct location',
        build: () => weatherBloc,
        seed: () => const WeatherState(
          status: WeatherStatus.success,
          weather: Weather(
              location: location,
              currentWeather: currentWeather,
              forecastWeatherList: forecastWeatherList),
        ),
        act: (bloc) => bloc.add(WeatherRefreshEvent()),
        verify: (_) =>
            verify(() => weatherRepository.getWeather(location: 'Bishkek'))
                .called(1),
      );

      blocTest('emits updated weather',
          build: () => weatherBloc,
          seed: () => const WeatherState(
                status: WeatherStatus.success,
                weather: Weather(
                    location: location,
                    currentWeather: weather_repository.CurrentWeather(
                        temperature: 15,
                        wind: 0,
                        humidity: 0,
                        cloud: 0,
                        condition: 'Unknown',
                        conditionImage: 'Unknown',
                        aqi: 0,
                        aqiCondition: 'Unknown',
                        date: '____-__-__',
                        sunrise: '__:__',
                        sunset: '__:__'),
                    forecastWeatherList: forecastWeatherList),
              ),
          act: (bloc) => bloc.add(WeatherRefreshEvent()),
          expect: () => [
                isA<WeatherState>().having(
                    (ws) => ws.weather.currentWeather.temperature,
                    'temperature',
                    15),
                isA<WeatherState>().having(
                    (ws) => ws.weather.currentWeather.temperature,
                    'temperature',
                    0)
              ]);
    });
  });
}
