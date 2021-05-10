import 'dart:math';

import 'package:intl/intl.dart';

class WeatherViewModel {
  final String asset, city, description, day, temperature;
  final Map<String, String> temperatureList;

  WeatherViewModel._(
    this.city,
    this.day,
    this.asset,
    this.description,
    this.temperature,
    this.temperatureList,
  );

  @override
  toString() {
    return asset +
        " " +
        description +
        " " +
        day +
        " " +
        " " +
        temperature +
        " ";
  }

  factory WeatherViewModel({
    int? temp,
    String? icon,
    DateTime? date,
    String? weatherDescription,
    double? humidity,
    String? areaName,
    required Map<DateTime, int?> temperatureList,
  }) {
    int tempMax = temperatureList.values.fold(
      -200,
      (previousValue, element) => max(previousValue, element ?? previousValue),
    );
    String temperature = "";
    if (temp != null) {
      temperature = temp.toString() + "°C";
    } else {
      temperature = tempMax.toString() + "°C";
    }

    String day = DateFormat('EEEE', 'de_DE').format(date ?? DateTime.now());

    String description = "";
    if (weatherDescription != null) {
      description += weatherDescription + ". ";
    }

    description +=
        "Die Höchsttemperatur wird bei " + tempMax.toString() + "°C liegen.";

    if (humidity != null) {
      //TODO: Warum kommt die humidity nicht
      description += "\nDie Luftfeuchtigkeit beträgt $humidity%.";
    }

    temperatureList.removeWhere((key, value) => value == null);

    return WeatherViewModel._(
      areaName ?? "",
      day,
      _iconToAsset[icon] ?? "",
      description,
      temperature,
      temperatureList.map(
        (key, value) => MapEntry(
          DateFormat('HH:MM', 'de_DE').format(key),
          value.toString() + "°",
        ),
      ),
    );
  }
}

const Map<String, String> _iconToAsset = {
  "01d": "assets/weather/Sonne.png",
  "02d": "assets/weather/Sonne_Bewölkt.png",
  "03d": "assets/weather/Bewölkt.png",
  "04d": "assets/weather/Bewölkt_Dunkel.png",
  "09d": "assets/weather/Regen.png",
  "10d": "assets/weather/Regen.png",
  "11d": "assets/weather/Gewitter.png",
  "13d": "assets/weather/Schnee.png",
  "50d": "assets/weather/Nebel.png",
  "01n": "assets/weather/Mond.png",
  "02n": "assets/weather/Mond_Bewölkt.png",
  "03n": "assets/weather/Bewölkt.png",
  "04n": "assets/weather/Bewölkt_Dunkel.png",
  "09n": "assets/weather/Regen.png",
  "10n": "assets/weather/Regen.png",
  "11n": "assets/weather/Gewitter.png",
  "13n": "assets/weather/Schnee.png",
  "50n": "assets/weather/Nebel.png",
};
