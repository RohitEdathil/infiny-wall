import 'package:flutter/material.dart';
import 'package:infiny_wall/models/brush.dart';
import 'package:infiny_wall/models/shape_definitions.dart';
import 'package:infiny_wall/models/shapes_list.dart';
import 'package:provider/provider.dart';

class Wall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onPanStart: (details) {
              Provider.of<ShapesList>(context, listen: false).addShape(Stroke(
                  initial: details.localPosition,
                  color: Provider.of<Brush>(context, listen: false).color,
                  size: Provider.of<Brush>(context, listen: false).size));
            },
            onPanUpdate: (details) {
              Provider.of<ShapesList>(context, listen: false)
                  .updateLastCurve(details.localPosition);
            },
            child: CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: Painter(
                  isDrawing: Provider.of<Brush>(context).isDrawing,
                  shapes: Provider.of<ShapesList>(context)),
            ),
          );
        },
      ),
    );
  }
}

class Painter extends CustomPainter {
  bool isDrawing;
  ShapesList shapes;
  Painter({this.isDrawing, this.shapes});
  Paint painter = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    shapes.renderAll(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
