import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infiny_wall/views/wall_view.dart';

void main() {
  runApp(InfinyWall());
}

class InfinyWall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.redAccent,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[400],
        sliderTheme: SliderThemeData(
            activeTrackColor: Colors.redAccent,
            inactiveTrackColor: Colors.grey[300],
            thumbColor: Colors.red,
            overlayColor: Colors.red[100]),
      ),
      home: WallView(),
    );
  }
}
