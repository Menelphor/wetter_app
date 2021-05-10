import 'package:equatable/equatable.dart';
import 'package:wetter_app/bloc/weather_bloc/weather_bloc.dart';
import 'package:wetter_app/data/model/weather_tbd.dart';

class WeatherState extends Equatable {
  final bool loading;
  final WeatherTbd? weather;
  final String? error;
  final WeatherDay weatherDay;

  WeatherState(this.loading, this.weather, this.weatherDay, this.error);

  factory WeatherState.loading(WeatherDay weatherDay) =>
      WeatherState(true, null, weatherDay, null);

  factory WeatherState.current(WeatherTbd current, WeatherDay weatherDay) =>
      WeatherState(false, current, weatherDay, null);

  factory WeatherState.error(String error, WeatherDay weatherDay) =>
      WeatherState(false, null, weatherDay, error);

  @override
  String toString() {
    String returnString = loading.toString();
    if (weather != null) {
      returnString += " " + weather.toString();
    }

    return returnString;
  }

  @override
  List<Object?> get props => [
        loading,
        weather,
        error,
      ];
}
