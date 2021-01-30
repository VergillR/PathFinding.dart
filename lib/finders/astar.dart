library pathfinding.finders.astar;

import 'dart:math';

import '../core/grid.dart';
import '../core/heap.dart';
import '../core/heuristic.dart';
import '../core/node.dart';
import '../core/util.dart';

import './finder.dart';

/// A* path-finder.
/// based upon https://github.com/bgrins/javascript-astar
/// @constructor
/// @param {object} opt
/// @param {boolean} opt.allowDiagonal Whether diagonal movement is allowed.
/// @param {boolean} opt.dontCrossCorners Disallow diagonal movement touching block corners.
/// @param {function} opt.heuristic Heuristic function to estimate the distance
///     (defaults to manhattan).
/// @param {integer} opt.weight Weight to apply to the heuristic to allow for suboptimal paths,
///     in order to speed up the search.
class AStarFinder extends Finder {
  bool allowDiagonal;
  bool dontCrossCorners;
  HeuristicFn heuristic;
  int weight;

  AStarFinder(
      {this.allowDiagonal = false,
      this.dontCrossCorners = false,
      this.heuristic = Heuristic.manhattan,
      this.weight = 1});

  /// Find and return the the path.
  /// @return {Array.<[number, number]>} The path, including both start and
  ///     end positions.
  @override
  List<List<int>> findPath(
      int startX, int startY, int endX, int endY, Grid grid) {
    final openList = Heap((dynamic nodeA, dynamic nodeB) {
      if (nodeA is Node && nodeB is Node) {
        return nodeA.f - nodeB.f;
      } else {
        return -1;
      }
    });
    final startNode = grid.getNodeAt(startX, startY);
    final endNode = grid.getNodeAt(endX, endY);
    final heuristic = this.heuristic;
    final allowDiagonal = this.allowDiagonal;
    final dontCrossCorners = this.dontCrossCorners;
    final weight = this.weight;
    Node? node;
    List<Node> neighbors;
    Node neighbor;
    int i = 0;
    int l = 0;
    int x = 0;
    int y = 0;
    int ng = 0;

    // set the `g` and `f` value of the start node to be 0
    startNode.g = 0;
    startNode.f = 0;

    // push the start node into the open list
    openList.push(startNode);
    startNode.opened = true;

    // while the open list is not empty
    if (node != null) {
      while (!openList.empty()) {
        // pop the position of node which has the minimum `f` value.
        node = openList.pop();
        node.closed = true;

        // if reached the end position, construct the path and return it
        if (node == endNode) {
          return backtrace(endNode);
        }

        // get neigbours of the current node
        neighbors = grid.getNeighbors(node,
            allowDiagonal: allowDiagonal, dontCrossCorners: dontCrossCorners);
        i = 0;
        for (l = neighbors.length; i < l; ++i) {
          neighbor = neighbors[i];

          if (neighbor.closed == true) {
            continue;
          }

          x = neighbor.x;
          y = neighbor.y;

          // get the distance between current node and the neighbor
          // and calculate the next g score
          ng = (node.g +
                  neighbor.cost +
                  ((x - node.x == 0 || y - node.y == 0) ? 1 : sqrt2))
              .toInt();

          // check if the neighbor has not been inspected yet, or
          // can be reached with smaller cost from the current node
          if (neighbor.opened != true || ng < neighbor.g) {
            neighbor.g = ng;
            if (neighbor.h == -1) {
              neighbor.h = (weight *
                      heuristic((x.toDouble() - endX.toDouble()).abs(),
                          (y.toDouble() - endY.toDouble()).abs()))
                  .toInt();
            }

            neighbor.f = neighbor.g + neighbor.h;
            neighbor.parent = node;

            if (neighbor.opened != true) {
              openList.push(neighbor);
              neighbor.opened = true;
            } else {
              // the neighbor can be reached with smaller cost.
              // Since its f value has been updated, we have to
              // update its position in the open list
              openList.updateItem(neighbor);
            }
          }
        } // end for each neighbor
      } // end while not open list empty

    }

    // fail to find the path
    return <List<int>>[];
  }
}
