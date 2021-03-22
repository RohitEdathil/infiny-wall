import 'package:flutter/material.dart';
import 'package:infiny_wall/views/wall.dart';

void main() {
  runApp(InfinyWall());
}

class InfinyWall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: Colors.redAccent,
        backgroundColor: Colors.white,
      ),
      home: WallView(),
    );
  }
}
