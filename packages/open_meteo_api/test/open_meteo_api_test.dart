import 'package:flutter_test/flutter_test.dart';

import 'package:open_meteo_api/open_meteo_api.dart';

void main() {
  group('Weather', () {
    group('fromJson', () {
      test('CurrentWeather', () =>
          expect(Location.fromJson(
              {
                "name": "Bishkek",
                "region": "Bishkek",
                "country": "Kyrghyzstan",
                "lat": 42.87,
                "lon": 74.6,
                "tz_id": "Asia/Bishkek",
                "localtime_epoch": 1671181169,
                "localtime": "2022-12-16 14:59"
              }
          ),
              isA<Location>().having((l) => l.name, 'location', 'Bishkek')));

      test('CurrentWeather', () =>
          expect(CurrentWeather.fromJson({
        "last_updated_epoch": 1670927400,
        "last_updated": "2022-12-13 16:30",
        "temp_c": -1.9,
        "temp_f": 28.6,
        "is_day": 1,
        "condition": {
          "text": "Sunny",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
          "code": 1000
        },
        "wind_mph": 2.2,
        "wind_kph": 3.6,
        "wind_degree": 307,
        "wind_dir": "NW",
        "pressure_mb": 1032.0,
        "pressure_in": 30.46,
        "precip_mm": 0.0,
        "precip_in": 0.0,
        "humidity": 84,
        "cloud": 0,
        "feelslike_c": -1.9,
        "feelslike_f": 28.6,
        "vis_km": 10.0,
        "vis_miles": 6.0,
        "uv": 2.0,
        "gust_mph": 2.0,
        "gust_kph": 3.2,
        "air_quality": {
          "co": 283.70001220703125,
          "no2": 11.800000190734863,
          "o3": 32.5,
          "so2": 7.099999904632568,
          "pm2_5": 15.899999618530273,
          "pm10": 19.5,
          "us-epa-index": 2,
          "gb-defra-index": 2
        }
      }),
      isA<CurrentWeather>().having((cw) => cw.temperature, 'temperature', -1.9)));
      
      test('ForecastWeather', () => expect(ForecastWeather.fromJson( {
      "date": "2022-12-13",
      "date_epoch": 1670889600,
      "day": {
      "maxtemp_c": 2.6,
      "maxtemp_f": 36.7,
      "mintemp_c": -7.6,
      "mintemp_f": 18.3,
      "avgtemp_c": -4.5,
      "avgtemp_f": 23.9,
      "maxwind_mph": 4.7,
      "maxwind_kph": 7.6,
      "totalprecip_mm": 0.0,
      "totalprecip_in": 0.0,
      "totalsnow_cm": 0.0,
      "avgvis_km": 10.0,
      "avgvis_miles": 6.0,
      "avghumidity": 67.0,
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
      "sunrise": "08:21 AM",
      "sunset": "05:25 PM",
      "moonrise": "09:59 PM",
      "moonset": "12:16 PM",
      "moon_phase": "Waning Gibbous",
      "moon_illumination": "62"
      },}), isA<ForecastWeather>().having((fw) => fw.day.temperature, 'temperature', -4.5)));
    }
    );
  });
}
