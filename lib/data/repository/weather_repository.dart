import 'package:weather/weather.dart';
import 'package:wetter_app/res/app_config.dart';

class WeatherRepository {
  final weatherFactory = new WeatherFactory(AppConfig.weatherApiKey);

  Future<Weather> getCurrentWeatherByLocation(double lat, double long) {
    // TODO: Caching
    // TODO: Error Handling
    return weatherFactory.currentWeatherByLocation(lat, long);
  }

  Future<List<Weather>> getForeCastWeatherByLocation(double lat, double long) {
    // TODO: Caching
    // TODO: Error Handling
    return weatherFactory.fiveDayForecastByLocation(lat, long);
  }

  Future<Weather> getCurrentWeatherByCity(String cityName) {
    // TODO: Caching
    // TODO: Error Handling
    return weatherFactory.currentWeatherByCityName(cityName);
  }

  Future<List<Weather>> getForeCastWeatherByCity(String cityName) {
    // TODO: Caching
    // TODO: Error Handling
    return weatherFactory.fiveDayForecastByCityName(cityName);
  }
}
