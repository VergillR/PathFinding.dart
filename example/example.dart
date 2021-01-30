// // import 'package:pathfinding/finders/jps.dart';
// import 'package:pathfinding/finders/astar.dart';
// import 'package:pathfinding/core/grid.dart';

// void main() {
//   // final grid1 = Grid(
//   //   4,
//   //   4,
//   //   [
//   //     [0, 0, 1, 1], // 0 - walkable, 1 - not walkable
//   //     [1, 0, 1, 1],
//   //     [1, 0, 1, 1],
//   //     [1, 0, 0, 0]
//   //   ],
//   // );
//   final grid2 = Grid(
//     8,
//     8,
//     // 0 - walkable, 1 - not walkable
//     [
//       [0, 0, 1, 1, 0, 0, 0, 0],
//       [1, 0, 1, 1, 0, 0, 0, 0],
//       [1, 0, 1, 1, 0, 0, 0, 0],
//       [1, 0, 0, 0, 0, 0, 0, 0],
//       [1, 0, 0, 0, 0, 0, 0, 0],
//       [1, 0, 0, 0, 0, 0, 0, 0],
//       [1, 0, 0, 0, 0, 0, 0, 0],
//       [1, 0, 0, 0, 0, 0, 0, 0],
//     ],
//     // costs (all costs are 0 if no costs are given)
//     [
//       [0, 0, 1, 1, 0, 0, 0, 0],
//       [1, 0, 1, 1, 0, 14, 0, 8],
//       [1, 0, 1, 1, 0, 14, 0, 0],
//       [1, 0, 0, 0, 0, 14, 18, 18],
//       [1, 0, 0, 0, 0, 0, 0, 0],
//       [1, 0, 0, 0, 0, 0, 0, 0],
//       [1, 0, 0, 0, 0, 0, 0, 0],
//       [1, 0, 0, 0, 0, 0, 0, 0],
//     ],
//   );
//   // final path = JumpPointFinder().findPath(0, 0, 3, 3, grid1.clone());
//   // print(path);

//   final pathWithCosts = AStarFinder().findPath(0, 0, 7, 2, grid2.clone());
//   print(pathWithCosts);
// }
