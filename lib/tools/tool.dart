import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infiny_wall/tools/brush_tool.dart';
import 'package:infiny_wall/tools/line_tool.dart';
import 'package:provider/provider.dart';

//Register tools here
final registeredTools = <Tool>[
  BrushTool(),
  LineTool(),
];

class ToolHolder extends ChangeNotifier {
  Tool currentTool;
  ToolHolder(Tool tool) {
    currentTool = tool;
  }
  set tool(Tool tool) {
    currentTool = tool;
    notifyListeners();
  }
}

abstract class Tool extends StatelessWidget {
  void start(Offset offset, BuildContext context) {}
  void update(Offset offset, BuildContext context) {}
  void end(BuildContext context) {}
  Widget renderButton(BuildContext context, IconData icon) {
    return GestureDetector(
      child: Container(
        height: 50,
        width: 50,
        child: Icon(
          icon,
          size: 35,
          color: Provider.of<ToolHolder>(context).currentTool.runtimeType ==
                  this.runtimeType
              ? Theme.of(context).accentColor
              : Colors.grey,
        ),
      ),
      onTap: () {
        Provider.of<ToolHolder>(context, listen: false).tool = this;
      },
    );
  }
}
