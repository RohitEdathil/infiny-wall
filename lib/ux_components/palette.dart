import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:infiny_wall/models/brush.dart';
import 'package:infiny_wall/models/shapes_list.dart';
import 'package:provider/provider.dart';

class Palette extends StatefulWidget {
  @override
  _PaletteState createState() => _PaletteState();
}

class _PaletteState extends State<Palette> with TickerProviderStateMixin {
  bool isDrawing;
  double thickness;
  Color _currentColor;
  AnimationController _animationController;
  AnimationController _scaleController;
  OverlayEntry _colorPickerOverlay;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        value: 1, vsync: this, duration: Duration(milliseconds: 250));
    _scaleController = AnimationController(
        value: 0, vsync: this, duration: Duration(milliseconds: 250));

    isDrawing = Provider.of<Brush>(context, listen: false).isDrawing;
    thickness = Provider.of<Brush>(context, listen: false).size;
    _currentColor = Provider.of<Brush>(context, listen: false).color;

    _colorPickerOverlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Color.fromARGB(100, 100, 100, 100),
          child: MaterialPicker(
            pickerColor: _currentColor,
            onColorChanged: changeColor,
          ),
        );
      },
    );
  }

  void handleTap() {
    setState(() {
      isDrawing
          ? _animationController.forward()
          : _animationController.reverse();
      !isDrawing ? _scaleController.forward() : _scaleController.reverse();
      isDrawing = !isDrawing;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void changeColor(Color color) {
    setState(() {
      _colorPickerOverlay.remove();
      _currentColor = color;
      Provider.of<Brush>(context, listen: false).changeColor(color);
    });
  }

  void changeSize(double size) {
    setState(() {
      thickness = size;
      Provider.of<Brush>(context, listen: false).changeSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ScaleTransition(
          scale: _scaleController,
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 60,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Container(
                width: 60,
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(5, 5),
                      )
                    ],
                    borderRadius: BorderRadius.circular(50)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: _currentColor,
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 1),
                        ),
                      ),
                      onTap: () {
                        Overlay.of(context).insert(_colorPickerOverlay);
                      },
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Slider(
                          value: thickness,
                          max: 100,
                          min: 1,
                          onChanged: changeSize),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        ScaleTransition(
          alignment: Alignment.centerRight,
          scale: _scaleController,
          child: Container(
            height: 60,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(5, 5),
                      )
                    ],
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          shape: CircleBorder(),
                          primary: Theme.of(context).accentColor),
                      onPressed: () {
                        Provider.of<ShapesList>(context, listen: false).undo();
                      },
                      child: Icon(
                        Icons.undo_rounded,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          shape: CircleBorder(),
                          primary: Theme.of(context).accentColor),
                      onPressed: () {
                        Provider.of<ShapesList>(context, listen: false).clear();
                      },
                      child: Icon(
                        Icons.delete_rounded,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          shape: CircleBorder(),
                          primary: Theme.of(context).accentColor),
                      onPressed: () {
                        Provider.of<ShapesList>(context, listen: false).redo();
                      },
                      child: Icon(
                        Icons.redo_rounded,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.red,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(5, 5),
                  )
                ]),
            child: IconButton(
              icon: AnimatedIcon(
                icon: AnimatedIcons.close_menu,
                progress: _animationController,
                color: Theme.of(context).backgroundColor,
              ),
              onPressed: handleTap,
            ))
      ],
    );
  }
}
