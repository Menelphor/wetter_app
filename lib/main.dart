import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:wetter_app/ui/screens/weather_screen.dart';

void main() {
  initializeDateFormatting('de_DE', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}
