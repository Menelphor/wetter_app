import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetter_app/bloc/weather_bloc/src/weather_event.dart';
import 'package:wetter_app/bloc/weather_bloc/src/weather_state.dart';
import 'package:wetter_app/data/repository/location_repository.dart';
import 'package:wetter_app/data/repository/weather_repository.dart';
import 'package:wetter_app/res/strings.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository = WeatherRepository();
  final LocationRepository _locationRepository = LocationRepository();

  WeatherBloc() : super(WeatherState.loading(WeatherDay.Today));

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is GetWeatherByLocation) {
      yield WeatherState.loading(event.weatherDay);
      final location = await _locationRepository.getLocation();
      try {
        final weather = await _weatherRepository.getWeatherByLocation(
          event.weatherDay,
          location!.latitude!,
          location.longitude!,
        );
        if (weather != null) {
          yield WeatherState.current(
            weather,
            event.weatherDay,
          );
        } else {
          yield WeatherState.error(Strings.weatherError, event.weatherDay);
        }
      } catch (e) {
        yield WeatherState.error(Strings.locationError, event.weatherDay);
        return;
      }
    }
  }
}

enum WeatherDay { Today, Tomorrow }
