import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetter_app/bloc/weather_bloc/src/weather_event.dart';
import 'package:wetter_app/bloc/weather_bloc/src/weather_state.dart';
import 'package:wetter_app/data/repository/location_repository.dart';
import 'package:wetter_app/data/repository/weather_repository.dart';
import 'package:wetter_app/res/strings.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;
  final LocationRepository _locationRepository;

  WeatherBloc(this._weatherRepository, this._locationRepository)
      : super(WeatherState.loading());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is GetCurrentInitialWeather) {
      final location = await _locationRepository.getLocation();
      try {
        final weather = await _weatherRepository.getCurrentWeatherByLocation(
          location!.latitude!,
          location.longitude!,
        );
        yield WeatherState.current(weather);
      } catch (e) {
        yield WeatherState.error(Strings.locationError);
        return;
      }
    }
  }
}
