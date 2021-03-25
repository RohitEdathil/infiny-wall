import 'package:flutter/material.dart';
import 'package:infiny_wall/models/brush.dart';
import 'package:infiny_wall/models/shapes_list.dart';
import 'package:infiny_wall/ux_components/palette.dart';
import 'package:infiny_wall/ux_components/wall.dart';
import 'package:provider/provider.dart';

class WallView extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Brush(color: Colors.black, size: 10, isDrawing: false),
        ),
        ChangeNotifierProvider(
          create: (_) => ShapesList(shapes: []),
        )
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        floatingActionButton: Palette(),
        body: Wall(),
      ),
    );
  }
}
