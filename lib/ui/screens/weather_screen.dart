import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wetter_app/bloc/weather_bloc/weather_bloc.dart';
import 'package:wetter_app/res/strings.dart';
import 'package:wetter_app/ui/widgets/platform_dialog.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherBloc()..add(GetWeatherByLocation(WeatherDay.Today)),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: _BodyWidget(state),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.weatherDay.index,
              selectedItemColor: Colors.yellow,
              selectedLabelStyle: TextStyle(color: Colors.yellow),
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: TextStyle(color: Colors.grey),
              items: [
                BottomNavigationBarItem(
                  icon: Image(
                    image: AssetImage("assets/Icon/Heute-weiß.png"),
                  ),
                  label: Strings.weatherDayToString[WeatherDay.Today],
                ),
                BottomNavigationBarItem(
                  icon: Image(
                    image: AssetImage("assets/Icon/Morgen-weiß.png"),
                  ),
                  label: Strings.weatherDayToString[WeatherDay.Tomorrow],
                ),
              ],
              onTap: (index) => context.read<WeatherBloc>().add(
                    GetWeatherByLocation(WeatherDay.values[index]),
                  ),
            ),
          );
        },
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  final WeatherState state;

  const _BodyWidget(
    this.state, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state.weather != null) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(flex: 1),
          Text(
            state.weather!.city,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 52),
          ),
          Text(
            state.weather!.day,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
          Spacer(flex: 1),
          state.weather?.asset != null
              ? Image(image: AssetImage(state.weather!.asset))
              : Container(),
          Spacer(flex: 1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(flex: 1),
              Expanded(
                flex: 9,
                child: Text(
                  state.weather!.temperature,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 52),
                ),
              ),
              Spacer(flex: 1),
              Expanded(
                flex: 9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("DETAILS"),
                    Divider(),
                    Text(
                      Strings.weatherDayToString[state.weatherDay]! +
                          ": " +
                          state.weather!.description,
                    ),
                  ],
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
          Spacer(
            flex: 1,
          ),
          ShowTemperatureButton(weatherState: state),
          Spacer(
            flex: 1,
          ),
        ],
      );
    }
    return SpinKitThreeBounce(
      color: Theme.of(context).accentColor,
    );
  }
}

class ShowTemperatureButton extends StatefulWidget {
  final WeatherState weatherState;

  const ShowTemperatureButton({Key? key, required this.weatherState})
      : super(key: key);

  @override
  _ShowTemperatureButtonState createState() => _ShowTemperatureButtonState();
}

class _ShowTemperatureButtonState extends State<ShowTemperatureButton> {
  final ValueNotifier<bool> _focused = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _focused,
      builder: (context, value, _) {
        return IconButton(
          icon: Image(
            image: value
                ? AssetImage("assets/Wolke/gelb.png")
                : AssetImage("assets/Wolke/grau.png"),
          ),
          onPressed: () async {
            _focused.value = true;
            await PlatformDialog.showPlatformAlertDialog(
              context: context,
              title: widget.weatherState.weather!.city,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: widget.weatherState.weather!.temperatureList
                    .map(
                      (key, value) => MapEntry(
                        key,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(key),
                              SizedBox(
                                width: 10,
                              ),
                              Text(value)
                            ],
                          ),
                        ),
                      ),
                    )
                    .values
                    .toList(),
              ),
              actions: [
                PlatformAlertButton(
                  buttonText: "OK",
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
            _focused.value = false;
          },
        );
      },
    );
  }
}
