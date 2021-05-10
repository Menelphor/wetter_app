import 'package:wetter_app/bloc/weather_bloc/weather_bloc.dart';

class Strings {
  static const locationError =
      "Auf deine Position konnte nicht zugegriffen werden.";
  static const weatherError = "Das Wetter konnte nicht geladen werden.";

  static const weatherDayToString = {
    WeatherDay.Today: "Heute",
    WeatherDay.Tomorrow: "Morgen",
  };
}
