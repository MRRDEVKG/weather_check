import 'package:flutter_test/flutter_test.dart';

import 'package:open_meteo_api/open_meteo_api.dart' as open_meteo_api;
import 'package:weather_repository/weather_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockOpenMeteoApiWeather extends Mock implements open_meteo_api.Weather {}

class MockLocation extends Mock implements open_meteo_api.Location{}

class MockOpenMeteoApiClient extends Mock
    implements open_meteo_api.OpenMeteoApiClient {}

class MockCurrentWeather extends Mock
    implements open_meteo_api.CurrentWeather {}

class MockForecastWeather extends Mock
    implements open_meteo_api.ForecastWeather {}

class MockDay extends Mock implements open_meteo_api.Day {}

class MockCondition extends Mock implements open_meteo_api.Condition {}

class MockAstro extends Mock implements open_meteo_api.Astro {}

class MockAqi extends Mock implements open_meteo_api.Aqi {}

void main() {
  group('WeatherRepository', () {
    late MockOpenMeteoApiClient openMeteoApiClient;
    late WeatherRepository weatherRepository;

    setUp(() {
      openMeteoApiClient = MockOpenMeteoApiClient();
      weatherRepository =
          WeatherRepository(weatherApiClient: openMeteoApiClient);
    });

    group('constructor', () {
      test('instantiates internal weather api client when not injected', () {
        expect(WeatherRepository(), isNotNull);
      });
    });

    group('getWeather', () {
      const location = 'Bishkek';

      //////////////////////////////////////////////////////////////////////////
      test('calls getWeather with correct location name', () async {
        final openMeteoApiWeather = MockOpenMeteoApiWeather();
        final location_ = MockLocation();
        final currentWeather = MockCurrentWeather();
        final forecastWeather = MockForecastWeather();
        // final listForecastWeather = [MockForecastWeather(), MockForecastWeather(), MockForecastWeather()];
        final day = MockDay();
        final condition = MockCondition();
        final astro = MockAstro();
        final aqi = MockAqi();

        when(() => openMeteoApiWeather.current).thenReturn(currentWeather);
        when(() => openMeteoApiWeather.forecast0).thenReturn(forecastWeather);
        when(() => openMeteoApiWeather.forecast1).thenReturn(forecastWeather);
        when(() => openMeteoApiWeather.forecast2).thenReturn(forecastWeather);
        when(() => openMeteoApiWeather.location).thenReturn(location_);

        //  when(() => listForecastWeather[0]).thenReturn(forecastWeather);
        //  when(() => listForecastWeather[1]).thenReturn(forecastWeather);
        //  when(() => listForecastWeather[2]).thenReturn(forecastWeather);
        //  when(()=> openMeteoApiWeather.forecast[0]).thenReturn(forecastWeather);
        //  when(()=> openMeteoApiWeather.forecast[1]).thenReturn(forecastWeather);
        //  when(()=> openMeteoApiWeather.forecast[2]).thenReturn(forecastWeather);

        when(() => location_.name).thenReturn('Bishkek');
        when(() => forecastWeather.astro).thenReturn(astro);
        when(() => forecastWeather.day).thenReturn(day);
        when(() => forecastWeather.date).thenReturn(DateTime(1998, 11, 1).toIso8601String());

        when(() => aqi.usEpaIndex).thenReturn(3);

        when(() => astro.sunrise).thenReturn('08:23 AM');
        when(() => astro.sunset).thenReturn('05:26 PM');

        when(() => condition.text).thenReturn('Sunny');
        when(() => condition.icon)
            .thenReturn('//cdn.weatherapi.com/weather/64x64/day/113.png');

        when(() => aqi.usEpaIndex).thenReturn(3);

        when(() => currentWeather.temperature).thenReturn(10.0);
        when(() => currentWeather.humidity).thenReturn(11.0);
        when(() => currentWeather.wind).thenReturn(12.0);
        when(() => currentWeather.cloud).thenReturn(13.0);
        when(() => currentWeather.condition).thenReturn(condition);
        when(() => currentWeather.airQuality).thenReturn(aqi);

        when(() => day.temperature).thenReturn(20.0);
        when(() => day.humidity).thenReturn(21.0);
        when(() => day.wind).thenReturn(22.0);
        when(() => day.condition).thenReturn(condition);

        ////////////////////////////////////////////////////////////////////////
        when(() =>
                openMeteoApiClient.getWeather(location: any(named: 'location')))
            .thenAnswer((_) async => openMeteoApiWeather);

        final actual =
            await weatherRepository.getWeather(location: location);

        expect(
            actual,
            isA<Weather>()
                .having((w) => w.location.name, 'location', 'Bishkek')
                .having(
                    (wc) => wc.currentWeather.temperature, 'temperature', 10.0)
                .having((wc) => wc.currentWeather.cloud, 'cloud', 13.0)
                .having((wf) => wf.forecastWeatherList[0].temperature,
                    'temperature', 20.0)
                .having((wf) => wf.forecastWeatherList[2].temperature,
                    'temperature', 20.0));
      });
    });
  });
}
