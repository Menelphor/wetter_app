class WeatherTbd {
  final String asset, city, cloudiness, day;
  final double humidity, temperature, temperatureMax;

  WeatherTbd._(this.city, this.day, this.asset, this.cloudiness,
      this.temperature, this.humidity, this.temperatureMax);
}
