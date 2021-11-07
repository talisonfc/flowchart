import 'package:flowchart/action_type.dart';
import 'package:flowchart/components/uml/uml_class.dart';
import 'package:flowchart/node.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  String? currentNode;
  ActionType actionType = ActionType.move;

  Map<String, Node> nodes = {
    '1': Node(position: Offset(0, 0)),
    '2': Node(position: Offset(0, 100)),
    '3': Node(position: Offset(0, 200)),
    '4': Node(position: Offset(0, 300))
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        onPointerMove: (event) {
          // print(event.position);
          final position = event.position;
          if (currentNode != null &&
              nodes[currentNode]!.localPosition != null) {
            setState(() {
              if (actionType == ActionType.resizeRight) {
                nodes[currentNode]!.width += event.delta.dx;
              } else if (actionType == ActionType.resizeLeft) {
                nodes[currentNode]!.width -= event.delta.dx;
                nodes[currentNode]!.position = Offset(
                    nodes[currentNode]!.position.dx + event.delta.dx,
                    nodes[currentNode]!.position.dy);
              } else if (actionType == ActionType.resizeTop) {
                nodes[currentNode]!.height -= event.delta.dy;
                nodes[currentNode]!.position = Offset(
                    nodes[currentNode]!.position.dx,
                    nodes[currentNode]!.position.dy + event.delta.dy);
              }
              else if (actionType == ActionType.resizeBottom) {
                nodes[currentNode]!.height += event.delta.dy;
              } else {
                nodes[currentNode]!.position = Offset(
                    position.dx - nodes[currentNode]!.localPosition!.dx,
                    position.dy - nodes[currentNode]!.localPosition!.dy);
              }
              // nodes[currentNode]!.position = Offset(
              //     position.dx -
              //         nodes[currentNode]!.localPosition!.dx +
              //         event.delta.dx,
              //     position.dy - nodes[currentNode]!.localPosition!.dy);
            });
          }
        },
        child: Container(
          // width: 500,
          // height: 500,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Stack(
            children: nodes
                .map((id, node) {
                  return MapEntry(
                      id,
                      UMLClass(
                        id: id,
                        top: node.position.dy,
                        left: node.position.dx,
                        width: node.width,
                        height: node.height,
                        onMouseEnter: (node) {
                          currentNode = node;
                        },
                        onMouseExit: (node) {
                          // currentNode = null;
                        },
                        onUpdateLocalPosition: (localPosition) {
                          node.localPosition = localPosition;
                        },
                        onChangeAction: (actionType) {
                          this.actionType = actionType;
                        },
                      ));
                })
                .values
                .toList(),
          ),
        ),
      ),
    );
  }
}
