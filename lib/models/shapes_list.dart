import 'package:flutter/material.dart';
import 'package:infiny_wall/models/shape_definitions.dart';

class ShapesList extends ChangeNotifier {
  List<Shape> shapes = [];
  List<Shape> _redo = [];
  ShapesList({this.shapes});
  void addShape(Shape shape) {
    shapes.add(shape);
    notifyListeners();
  }

  void renderAll(Canvas canvas) {
    shapes.forEach((shape) {
      shape.render(canvas);
    });
  }

  void refresh() {
    this._redo.clear();
    notifyListeners();
  }

  void undo() {
    if (this.shapes.isNotEmpty) {
      this._redo.add(this.shapes.last);
      this.shapes.removeAt(this.shapes.length - 1);
      notifyListeners();
    }
  }

  void redo() {
    if (this._redo.isNotEmpty) {
      this.shapes.add(_redo.last);
      this._redo.removeAt(this._redo.length - 1);
    }
  }

  void clear() {
    this.shapes.clear();
    notifyListeners();
  }
}
