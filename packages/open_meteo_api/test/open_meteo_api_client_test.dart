import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:open_meteo_api/open_meteo_api.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('OpenMeteoApiClient', () {
    late MockHttpClient httpClient;
    late OpenMeteoApiClient apiClient;
    const String location = 'Bishkek';
    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = OpenMeteoApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(OpenMeteoApiClient(), isNotNull);
      });
    });

    group('getWeather', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any()))
            .thenAnswer((_) => Future.value(response));

        try {
          await apiClient.getWeather(location: location);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.http('api.weatherapi.com', 'v1/forecast.json', {
              'key': '63a7ad0853774c31acc123024221212',
              'days': '5',
              'aqi': 'yes',
              'alerts': 'no',
              'hour': '-1',
              'q': location,
            }),
          ),
        ).called(1);
      });

      test('throws WeatherRequestFailure on non-200 response', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any()))
            .thenAnswer((_) => Future.value(response));

        expect(() => apiClient.getWeather(location: location),
            throwsA(isA<WeatherRequestFailure>()));
      });

      test('throws WeatherNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json.encode({}));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        expect(() => apiClient.getWeather(location: location),
            throwsA(isA<WeatherNotFoundFailure>()));
      });

      test('returns weather on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(json.encode({
          "location": {
            "name": "Bishkek",
            "region": "Bishkek",
            "country": "Kyrghyzstan",
            "lat": 42.87,
            "lon": 74.6,
            "tz_id": "Asia/Bishkek",
            "localtime_epoch": 1671181169,
            "localtime": "2022-12-16 14:59"
          },
          "current": {
            "last_updated_epoch": 1671180300,
            "last_updated": "2022-12-16 14:45",
            "temp_c": 6.5,
            "temp_f": 43.7,
            "is_day": 1,
            "condition": {
              "text": "Sunny",
              "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
              "code": 1000
            },
            "wind_mph": 4.0,
            "wind_kph": 6.5,
            "wind_degree": 88,
            "wind_dir": "E",
            "pressure_mb": 1023.0,
            "pressure_in": 30.2,
            "precip_mm": 0.0,
            "precip_in": 0.0,
            "humidity": 65,
            "cloud": 0,
            "feelslike_c": 5.3,
            "feelslike_f": 41.5,
            "vis_km": 10.0,
            "vis_miles": 6.0,
            "uv": 3.0,
            "gust_mph": 8.5,
            "gust_kph": 13.7,
            "air_quality": {
              "co": 220.3000030517578,
              "no2": 5.900000095367432,
              "o3": 57.20000076293945,
              "so2": 3.200000047683716,
              "pm2_5": 3.700000047683716,
              "pm10": 4.900000095367432,
              "us-epa-index": 1,
              "gb-defra-index": 1
            }
          },
          "forecast": {
            "forecastday": [
              {
                "date": "2022-12-16",
                "date_epoch": 1671148800,
                "day": {
                  "maxtemp_c": 6.5,
                  "maxtemp_f": 43.7,
                  "mintemp_c": -1.6,
                  "mintemp_f": 29.1,
                  "avgtemp_c": 1.0,
                  "avgtemp_f": 33.8,
                  "maxwind_mph": 6.7,
                  "maxwind_kph": 10.8,
                  "totalprecip_mm": 0.0,
                  "totalprecip_in": 0.0,
                  "totalsnow_cm": 0.0,
                  "avgvis_km": 10.0,
                  "avgvis_miles": 6.0,
                  "avghumidity": 55.0,
                  "daily_will_it_rain": 0,
                  "daily_chance_of_rain": 0,
                  "daily_will_it_snow": 0,
                  "daily_chance_of_snow": 0,
                  "condition": {
                    "text": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "code": 1000
                  },
                  "uv": 2.0
                },
                "astro": {
                  "sunrise": "08:23 AM",
                  "sunset": "05:26 PM",
                  "moonrise": "12:06 AM",
                  "moonset": "01:24 PM",
                  "moon_phase": "Last Quarter",
                  "moon_illumination": "40"
                },
                "hour": []
              },
              {
                "date": "2022-12-17",
                "date_epoch": 1671235200,
                "day": {
                  "maxtemp_c": 4.6,
                  "maxtemp_f": 40.3,
                  "mintemp_c": -4.3,
                  "mintemp_f": 24.3,
                  "avgtemp_c": -0.7,
                  "avgtemp_f": 30.7,
                  "maxwind_mph": 4.7,
                  "maxwind_kph": 7.6,
                  "totalprecip_mm": 0.0,
                  "totalprecip_in": 0.0,
                  "totalsnow_cm": 0.0,
                  "avgvis_km": 10.0,
                  "avgvis_miles": 6.0,
                  "avghumidity": 64.0,
                  "daily_will_it_rain": 0,
                  "daily_chance_of_rain": 0,
                  "daily_will_it_snow": 0,
                  "daily_chance_of_snow": 0,
                  "condition": {
                    "text": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "code": 1000
                  },
                  "uv": 2.0
                },
                "astro": {
                  "sunrise": "08:24 AM",
                  "sunset": "05:26 PM",
                  "moonrise": "01:10 AM",
                  "moonset": "01:44 PM",
                  "moon_phase": "Last Quarter",
                  "moon_illumination": "33"
                },
                "hour": []
              },
              {
                "date": "2022-12-18",
                "date_epoch": 1671321600,
                "day": {
                  "maxtemp_c": 7.3,
                  "maxtemp_f": 45.1,
                  "mintemp_c": -5.8,
                  "mintemp_f": 21.6,
                  "avgtemp_c": -1.5,
                  "avgtemp_f": 29.3,
                  "maxwind_mph": 5.4,
                  "maxwind_kph": 8.6,
                  "totalprecip_mm": 0.0,
                  "totalprecip_in": 0.0,
                  "totalsnow_cm": 0.0,
                  "avgvis_km": 10.0,
                  "avgvis_miles": 6.0,
                  "avghumidity": 55.0,
                  "daily_will_it_rain": 0,
                  "daily_chance_of_rain": 0,
                  "daily_will_it_snow": 0,
                  "daily_chance_of_snow": 0,
                  "condition": {
                    "text": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "code": 1000
                  },
                  "uv": 2.0
                },
                "astro": {
                  "sunrise": "08:24 AM",
                  "sunset": "05:27 PM",
                  "moonrise": "02:15 AM",
                  "moonset": "02:04 PM",
                  "moon_phase": "Waning Crescent",
                  "moon_illumination": "26"
                },
                "hour": []
              }
            ]
          }
        }));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        final actual = await apiClient.getWeather(location: location);

        expect(
          actual,
          isA<Weather>()
              .having((w) => w.location.name, 'location', 'Bishkek')
              .having((wc) => wc.current.temperature, 'temperature', 6.5)
              .having(
                  (wf) => wf.forecast2.day.temperature, 'temperature', -1.5),
        );
      });
    });
  });
}
