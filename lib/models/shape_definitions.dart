import 'package:flutter/material.dart';

class Shape {
  List<Offset> data;
  void render(Canvas canvas) {}
}

class Stroke extends Shape {
  List<Offset> data = [];
  Color color;
  double size;
  Stroke({Offset initial, this.color, this.size}) {
    data.add(initial);
  }
  Paint paint = Paint();

  @override
  void render(Canvas canvas) {
    paint.color = color;

    if (data.length > 1) {
      paint.strokeWidth = size;
      paint.style = PaintingStyle.stroke;
      canvas.drawCircle(data[0], size / 64, paint);
      Path path = Path();
      path.moveTo(data[0].dx, data[0].dy);
      for (var i = 1; i < data.length; i++) {
        path.quadraticBezierTo(
            data[i - 1].dx, data[i - 1].dy, data[i].dx, data[i].dy);
      }
      canvas.drawCircle(data[data.length - 1], size / 64, paint);
      canvas.drawPath(path, paint);
    } else {
      canvas.drawCircle(data[0], size / 2, paint);
    }
  }
}

class Line extends Shape {
  List<Offset> data = [];
  Color color;
  double size;
  Line({Offset initial, this.color, this.size}) {
    data.add(initial);
    data.add(initial);
  }
  Paint paint = Paint();
  @override
  void render(Canvas canvas) {
    paint.color = color;
    paint.strokeWidth = size;
    canvas.drawLine(data[0], data[1], paint);
    canvas.drawCircle(data[0], size / 2, paint);
    canvas.drawCircle(data[1], size / 2, paint);
  }
}

class ClosedPath extends Shape {
  List<Offset> data = [];
  Color color;
  double size;
  ClosedPath({Offset initial, this.color, this.size}) {
    data.add(initial);
  }
  Paint paint = Paint();
  @override
  void render(Canvas canvas) {
    paint.color = color;

    if (data.length > 1) {
      paint.strokeWidth = size;
      paint.style = PaintingStyle.fill;
      Path path = Path();
      path.moveTo(data[0].dx, data[0].dy);
      for (var i = 1; i < data.length; i++) {
        path.quadraticBezierTo(
            data[i - 1].dx, data[i - 1].dy, data[i].dx, data[i].dy);
      }

      path.close();
      canvas.drawPath(path, paint);
    } else {
      canvas.drawCircle(data[0], size / 2, paint);
    }
  }
}
