import 'package:wetter_app/bloc/weather_bloc/weather_bloc.dart';

class WeatherEvent {}

class GetWeatherByLocation extends WeatherEvent {
  final WeatherDay weatherDay;

  GetWeatherByLocation(this.weatherDay);
}

class GetCurrentWeatherByCity extends WeatherEvent {}
