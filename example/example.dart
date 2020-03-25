import 'package:pathfinding/finders/jps.dart';
import 'package:pathfinding/finders/astar.dart';
import 'package:pathfinding/core/grid.dart';

main() {
  var grid1 = new Grid(
    4,
    4,
    [
      [0, 0, 1, 1], // 0 - walkable, 1 - not walkable
      [1, 0, 1, 1],
      [1, 0, 1, 1],
      [1, 0, 0, 0]
    ],
  );
  var grid2 = new Grid(
    8,
    8,
    // 0 - walkable, 1 - not walkable
    [
      [0, 0, 1, 1, 0, 0, 0, 0],
      [1, 0, 1, 1, 0, 0, 0, 0],
      [1, 0, 1, 1, 0, 0, 0, 0],
      [1, 0, 0, 0, 0, 0, 0, 0],
      [1, 0, 0, 0, 0, 0, 0, 0],
      [1, 0, 0, 0, 0, 0, 0, 0],
      [1, 0, 0, 0, 0, 0, 0, 0],
      [1, 0, 0, 0, 0, 0, 0, 0],
    ],
    [
      [0, 0, 1, 1, 0, 0, 0, 0],
      [1, 0, 1, 1, 0, 4, 0, 1],
      [1, 0, 1, 1, 0, 4, 0, 0],
      [1, 0, 0, 0, 0, 4, 2, 2],
      [1, 0, 0, 0, 0, 0, 0, 0],
      [1, 0, 0, 0, 0, 0, 0, 0],
      [1, 0, 0, 0, 0, 0, 0, 0],
      [1, 0, 0, 0, 0, 0, 0, 0],
    ],
  );
  // var path = new JumpPointFinder().findPath(0, 0, 3, 3, grid.clone());
  // print(path); // [[0, 0], [1, 1], [1, 2], [2, 3], [3, 3]]

  var path = new AStarFinder().findPath(0, 0, 7, 2, grid2.clone());
  print(path); // [[0, 0], [1, 0], [1, 1], [1, 2], [1, 3], [2, 3], [3, 3]]

  var path2 = new AStarFinder().findPath(0, 0, 6, 6, grid2.clone());
  print(path2); // [[0, 0], [1, 0], [1, 1], [1, 2], [1, 3], [2, 3], [3, 3]]
}
