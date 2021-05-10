import 'package:weather/weather.dart';
import 'package:wetter_app/bloc/weather_bloc/weather_bloc.dart';
import 'package:wetter_app/data/model/weather_tbd.dart';
import 'package:wetter_app/res/app_config.dart';

class WeatherRepository {
  final weatherFactory = WeatherFactory(
    AppConfig.weatherApiKey,
    language: Language.GERMAN,
  );

  Future<WeatherViewModel?> getWeatherByLocation(
    WeatherDay weatherDay,
    double lat,
    double long,
  ) async {
    try {
      List<Weather> weatherList =
          await weatherFactory.fiveDayForecastByLocation(49.825702, 8.647984);
      final date = weatherDay == WeatherDay.Today
          ? DateTime.now()
          : DateTime.now().add(const Duration(days: 1));

      weatherList.removeWhere((element) => element.date?.day != date.day);

      final city = weatherList
          .firstWhere((element) => element.areaName != null)
          .areaName!;

      final Map<DateTime, int?> temperatureList = {};

      weatherList.forEach((element) {
        temperatureList[element.date!] = element.temperature?.celsius?.toInt();
      });

      switch (weatherDay) {
        case WeatherDay.Today:
          final actualWeather =
              await weatherFactory.currentWeatherByLocation(lat, long);

          return WeatherViewModel(
            areaName: city,
            icon: actualWeather.weatherIcon,
            date: date,
            humidity: actualWeather.humidity,
            temp: actualWeather.temperature?.celsius?.toInt(),
            temperatureList: temperatureList,
            weatherDescription: actualWeather.weatherDescription,
          );
        case WeatherDay.Tomorrow:
          // TODO: Wetter für nächsten TAG? Welche werte nimmt man da
          final actualWeather = weatherList.firstWhere(
            (element) => date.difference(element.date!).inHours < 3,
          );

          return WeatherViewModel(
            areaName: city,
            icon: actualWeather.weatherIcon,
            date: date,
            humidity: actualWeather.humidity,
            temperatureList: temperatureList,
            weatherDescription: actualWeather.weatherDescription,
          );
      }
    } catch (e) {
      return null;
    }
  }
}
