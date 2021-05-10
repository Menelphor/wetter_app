import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetter_app/bloc/weather_bloc/weather_bloc.dart';
import 'package:wetter_app/data/repository/location_repository.dart';
import 'package:wetter_app/data/repository/weather_repository.dart';

void main() {
  runApp(MyApp(
      weatherRepository: WeatherRepository(),
      locationRepository: LocationRepository()));
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;
  final LocationRepository locationRepository;

  const MyApp({
    Key? key,
    required this.weatherRepository,
    required this.locationRepository,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherBloc(weatherRepository, locationRepository)
        ..add(GetCurrentInitialWeather()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(),
      ),
    );
  }
}
