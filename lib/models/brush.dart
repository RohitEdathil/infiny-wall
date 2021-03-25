import 'package:flutter/material.dart';

class Brush extends ChangeNotifier {
  Color color;
  double size;
  bool isDrawing;
  Brush({this.color, this.size, this.isDrawing});

  void changeColor(Color color) {
    this.color = color;
    notifyListeners();
  }

  void changeSize(double size) {
    this.size = size;
    notifyListeners();
  }
}
