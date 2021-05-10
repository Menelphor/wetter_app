import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';

class WeatherState extends Equatable {
  final bool loading;
  final Weather? weather;
  final List<Weather>? foreCast;
  final String? error;

  WeatherState(this.loading, this.weather, this.foreCast, this.error);

  factory WeatherState.loading() => WeatherState(true, null, null, null);

  factory WeatherState.current(Weather current) =>
      WeatherState(false, current, null, null);

  factory WeatherState.forecast(Weather current, List<Weather> forecast) =>
      WeatherState(false, current, forecast, null);

  factory WeatherState.error(String error) =>
      WeatherState(false, null, null, error);

  @override
  List<Object> get props => [
        loading,
        weather?.toString() ?? "",
        (foreCast ?? []).map((e) => e.toString()).toList().join(),
        error ?? ""
      ];
}
