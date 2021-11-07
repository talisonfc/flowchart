import 'package:flowchart/action_type.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UMLClass extends StatefulWidget {
  final String id;
  final double top, left, width, height;

  // final Function(String index, Offset localPosition) onLocalPosition;
  final Function(Offset localPosition) onUpdateLocalPosition;
  final Function(ActionType actionType) onChangeAction;
  final Function(String index) onMouseEnter;
  final Function(String index) onMouseExit;

  UMLClass(
      {required this.id,
      required this.top,
      required this.left,
      required this.onMouseEnter,
      required this.onMouseExit,
      required this.onUpdateLocalPosition,
      required this.onChangeAction,
      this.width = 200,
      this.height = 200});

  @override
  State<StatefulWidget> createState() {
    return _UMLClassState();
  }
}

class _UMLClassState extends State<UMLClass> {
  bool inFoco = false;
  MouseCursor mouseCursor = SystemMouseCursors.click;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      left: widget.left,
      child: MouseRegion(
        cursor: mouseCursor,
        onEnter: (event) {
          widget.onMouseEnter(widget.id);
          setState(() {
            inFoco = true;
          });
        },
        onHover: (event) {
          Offset p = event.localPosition;
          widget.onUpdateLocalPosition(p);
          if (p.dy < 10 || ((widget.height - p.dy)) < 10) {
            widget.onChangeAction(
                p.dy < 10 ? ActionType.resizeTop : ActionType.resizeBottom);
            setState(() {
              mouseCursor = SystemMouseCursors.resizeRow;
            });
          } else if (p.dx < 10 || (widget.width - p.dx) < 10) {
            widget.onChangeAction(
                p.dx < 10 ? ActionType.resizeLeft : ActionType.resizeRight);
            setState(() {
              mouseCursor = SystemMouseCursors.resizeColumn;
            });
          } else {
            widget.onChangeAction(ActionType.move);
            setState(() {
              mouseCursor = SystemMouseCursors.help;
            });
          }
        },
        onExit: (event) {
          widget.onMouseExit(widget.id);
          setState(() {
            inFoco = false;
          });
        },
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: inFoco ? 2 : 1),
            color: Colors.white,
            // borderRadius: BorderRadius.all(Radius.circular(5)),
            // boxShadow: [BoxShadow(offset: Offset.zero, blurRadius: 2)],
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                '<<esteriotipo>>',
                textAlign: TextAlign.center,
              ),
              Text(
                'classname',
                textAlign: TextAlign.center,
              ),
              Divider(),
              TextButton(
                  onPressed: () {
                    print('add');
                  },
                  child: Text('add prop')),
              Divider(),
              TextButton(
                  onPressed: () {
                    print('add');
                  },
                  child: Text('add method')),
            ],
          ),
        ),
      ),
    );
  }
}
