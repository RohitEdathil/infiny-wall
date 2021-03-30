import 'package:flutter/material.dart';
import 'package:infiny_wall/models/brush.dart';
import 'package:infiny_wall/models/shape_definitions.dart';
import 'package:infiny_wall/models/shapes_list.dart';
import 'package:infiny_wall/tools/tool.dart';
import 'package:provider/provider.dart';

class LineTool extends Tool {
  @override
  void start(Offset offset, BuildContext context) {
    Provider.of<ShapesList>(context, listen: false).addShape(Line(
        initial: offset,
        color: Provider.of<Brush>(context, listen: false).color,
        size: Provider.of<Brush>(context, listen: false).size));
  }

  @override
  void update(Offset offset, BuildContext context) {
    Provider.of<ShapesList>(context, listen: false).shapes.last.data[1] =
        offset;
    Provider.of<ShapesList>(context, listen: false).refresh();
  }

  @override
  void end(BuildContext context) {
    //TODO : Implement Network sync here
  }
  @override
  Widget build(BuildContext context) {
    return renderButton(context, Icons.horizontal_rule_rounded);
  }
}
