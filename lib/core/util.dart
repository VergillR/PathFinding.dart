library pathfinding.core.util;

import 'dart:math';
import './grid.dart';
import './node.dart';

// num abs(num val) => val < 0 ? -val : val;

/// Backtrace according to the parent records and return the path.
/// (including both start and end nodes)
/// @param {Node} node End node
/// @return {Array.<Array.<number>>} the path
List<List<int>> backtrace(Node n) {
  Node node = n;
  final path = [
    [node.x, node.y]
  ];
  while (node.parent != null) {
    node = node.parent!;
    path.add([node.x, node.y]);
  }

  return path.reversed.toList();
}

/// Backtrace from start and end node, and return the path.
/// (including both start and end nodes)
/// @param {Node}
/// @param {Node}
List<List<int>> biBacktrace(Node nodeA, Node nodeB) {
  final pathA = backtrace(nodeA), pathB = backtrace(nodeB);
  final l = List<List<int>>.from(pathA)..addAll(pathB.reversed);
  return l;
}

/// Compute the length of the path.
/// @param {Array.<Array.<number>>} path The path
/// @return {number} The length of the path
int pathLength(List<List<int>> path) {
  int i = 1;
  double sum = 0.0;

  for (i = 1; i < path.length; ++i) {
    final a = path[i - 1];
    final b = path[i];
    final dx = a[0] - b[0];
    final dy = a[1] - b[1];
    sum += sqrt(dx * dx + dy * dy);
  }
  return sum.toInt();
}

/// Given the start and end coordinates, return all the coordinates lying
/// on the line formed by these coordinates, based on Bresenham's algorithm.
/// http://en.wikipedia.org/wiki/Bresenham's_line_algorithm#Simplification
/// @param {number} x0 Start x coordinate
/// @param {number} y0 Start y coordinate
/// @param {number} x1 End x coordinate
/// @param {number} y1 End y coordinate
/// @return {Array.<Array.<number>>} The coordinates on the line
List<List<int>> getLine(int x00, int y00, int x11, int y11) {
  int x0 = x00;
  int y0 = y00;
  final int x1 = x11;
  final int y1 = y11;
  final List<List<int>> line = [];
  int e2 = 0;

  final dx = (x1 - x0).abs();
  final dy = (y1 - y0).abs();

  final sx = (x0 < x1) ? 1 : -1;
  final sy = (y0 < y1) ? 1 : -1;

  int err = (dx - dy).toInt();

  while (true) {
    line.add([x0, y0]);

    if (x0 == x1 && y0 == y1) {
      break;
    }

    e2 = 2 * err;
    if (e2 > -dy) {
      err = err - dy;
      x0 = x0 + sx;
    }
    if (e2 < dx) {
      err = err + dx;
      y0 = y0 + sy;
    }
  }

  return line;
}

/// Smoothen the give path.
/// The original path will not be modified; a new path will be returned.
/// @param {PF.Grid} grid
/// @param {Array.<Array.<number>>} path The path
/// @return {Array.<Array.<number>>} Smoothened path
List<List<int>> smoothenPath(Grid grid, List<List<int>> path) {
  final int len = path.length;
  final int x0 = path[0][0]; // path start x
  final int y0 = path[0][1]; // path start y
  final int x1 = path[len - 1][0]; // path end x
  final int y1 = path[len - 1][1]; // path end y
  // int sx = 0;
  // int sy = 0; // current start coordinate
  int ex = 0;
  int ey = 0; // current end coordinate
  // int lx = 0;
  // int ly = 0; // last valid end coordinate
  // List<List<int>> newPath = [<int>[]];
  int i = 0;
  int j = 0;
  List<int>? coord;
  List<List<int>>? line;
  List<int>? testCoord;
  bool blocked = false;

  int sx = x0;
  int sy = y0;
  int lx = path[1][0];
  int ly = path[1][1];
  final List<List<int>> newPath = [
    [sx, sy]
  ];

  for (i = 2; i < len; ++i) {
    coord = path[i];
    ex = coord[0];
    ey = coord[1];
    line = getLine(sx, sy, ex, ey);

    blocked = false;
    for (j = 1; j < line.length; ++j) {
      testCoord = line[j];

      if (!grid.isWalkableAt(testCoord[0], testCoord[1])) {
        blocked = true;
        newPath.add([lx, ly]);
        sx = lx;
        sy = ly;
        break;
      }
    }
    if (!blocked) {
      lx = ex;
      ly = ey;
    }
  }
  newPath.add([x1, y1]);

  return newPath;
}
