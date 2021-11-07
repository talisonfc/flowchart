import 'package:flutter/cupertino.dart';

class Node {
  Offset? localPosition;
  Offset position;
  double width, height;

  Node(
      {required this.position,
      this.localPosition,
      this.width = 200,
      this.height = 200});
}
