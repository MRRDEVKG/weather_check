import 'package:open_meteo_api/open_meteo_api.dart' as open_meteo_api;
import 'package:weather_repository/weather_repository.dart';

class WeatherRepository {
  WeatherRepository({open_meteo_api.OpenMeteoApiClient? weatherApiClient})
      : _weatherApiClient =
            weatherApiClient ?? open_meteo_api.OpenMeteoApiClient();
  final open_meteo_api.OpenMeteoApiClient _weatherApiClient;

  Future<Weather> getWeather({required String location}) async {
    final weather = await _weatherApiClient.getWeather(location: location);
    final location_ = Location(name: weather.location.name);

    final currentWeather = CurrentWeather(
        temperature: weather.current.temperature,
        wind: weather.current.wind,
        humidity: weather.current.humidity,
        cloud: weather.current.cloud,
        condition: weather.current.condition.text,
        conditionImage: weather.current.condition.icon,
        aqi: weather.current.airQuality.usEpaIndex,
        aqiCondition: aqiCondition[weather.current.airQuality.usEpaIndex]!,
        date: weather.forecast0.date,
        sunrise: weather.forecast0.astro.sunrise,
        sunset: weather.forecast0.astro.sunset);

    final forecastWeather0 = ForecastWeather(
            temperature: weather.forecast0.day.temperature,
            wind: weather.forecast0.day.wind,
            humidity: weather.forecast0.day.humidity,
            condition: weather.forecast0.day.condition.text,
            conditionImage: weather.forecast0.day.condition.icon,
            date: weather.forecast0.date,
            sunrise: weather.forecast0.astro.sunrise,
            sunset: weather.forecast0.astro.sunset);

    final forecastWeather1 = ForecastWeather(
        temperature: weather.forecast1.day.temperature,
        wind: weather.forecast1.day.wind,
        humidity: weather.forecast1.day.humidity,
        condition: weather.forecast1.day.condition.text,
        conditionImage: weather.forecast1.day.condition.icon,
        date: weather.forecast1.date,
        sunrise: weather.forecast1.astro.sunrise,
        sunset: weather.forecast1.astro.sunset);

    final forecastWeather2 = ForecastWeather(
        temperature: weather.forecast2.day.temperature,
        wind: weather.forecast2.day.wind,
        humidity: weather.forecast2.day.humidity,
        condition: weather.forecast2.day.condition.text,
        conditionImage: weather.forecast2.day.condition.icon,
        date: weather.forecast2.date,
        sunrise: weather.forecast2.astro.sunrise,
        sunset: weather.forecast2.astro.sunset);

    return Weather(
        location: location_,
        currentWeather: currentWeather,
        forecastWeatherList: [forecastWeather0, forecastWeather1, forecastWeather2]);
  }
}

