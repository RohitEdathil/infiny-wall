import 'package:flutter/material.dart';
import 'package:infiny_wall/models/brush.dart';
import 'package:infiny_wall/models/shapes_list.dart';
import 'package:infiny_wall/tools/tool.dart';
import 'package:provider/provider.dart';

class Wall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onPanStart: (details) {
              Provider.of<ToolHolder>(context, listen: false)
                  .currentTool
                  .start(details.localPosition, context);
            },
            onPanUpdate: (details) {
              Provider.of<ToolHolder>(context, listen: false)
                  .currentTool
                  .update(details.localPosition, context);
            },
            onPanEnd: (details) {
              Provider.of<ToolHolder>(context, listen: false)
                  .currentTool
                  .end(context);
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
