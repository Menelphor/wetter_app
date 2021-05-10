import 'package:flutter/material.dart';

class TodayScreen extends StatelessWidget {
  TodayScreen._({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => TodayScreen._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [Text("hi")],
      ),
    );
  }
}
