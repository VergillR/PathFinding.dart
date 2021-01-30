// import 'test_util.dart';
// import 'package:pathfinding/finders/jps.dart';
// import 'package:pathfinding/finders/astar.dart';
// import 'package:pathfinding/core/grid.dart';
// import 'package:test/test.dart';

// var scenarios = [
//   {
//     'startX': 0,
//     'startY': 0,
//     'endX': 1,
//     'endY': 1,
//     'matrix': [
//       [0, 0],
//       [1, 0]
//     ],
//     'expectedLength': 3,
//   },
//   {
//     'startX': 1,
//     'startY': 1,
//     'endX': 4,
//     'endY': 4,
//     'matrix': [
//       [0, 0, 0, 0, 0],
//       [1, 0, 1, 1, 0],
//       [1, 0, 1, 0, 0],
//       [0, 1, 0, 0, 0],
//       [1, 0, 1, 1, 0],
//       [0, 0, 1, 0, 0]
//     ],
//     'costs': [
//       [0, 0, 0, 0, 0],
//       [9, 9, 9, 9, 0],
//       [0, 0, 0, 0, 0],
//       [0, 9, 9, 9, 9],
//       [0, 0, 0, 0, 0]
//     ],
//     'expectedLength': 9,
//     'expectedCostLength': 17,
//   },
//   {
//     'startX': 0,
//     'startY': 3,
//     'endX': 3,
//     'endY': 3,
//     'matrix': [
//       [0, 0, 0, 0, 0],
//       [0, 0, 1, 1, 0],
//       [0, 0, 1, 0, 0],
//       [0, 0, 1, 0, 0],
//       [1, 0, 1, 1, 0],
//       [0, 0, 0, 0, 0]
//     ],
//     'expectedLength': 10,
//   },
//   {
//     'startX': 4,
//     'startY': 4,
//     'endX': 19,
//     'endY': 19,
//     'matrix': [
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
//       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
//     ],
//     'expectedLength': 31,
//   },
// ];

// /**
//  * Path-finding tests for the path-finders.
//  * @param {boolean} opt.optimal - Whether the finder is guaranteed to find the shortest path
//  * @param {boolean} opt.useCost - Whether the finder should use costs
//  */
// pathTest(name, finder, optimal, useCost) {
//   describe(name, () {
//     var startX,
//         startY,
//         endX,
//         endY,
//         grid,
//         expectedLength,
//         width,
//         height,
//         matrix,
//         costs,
//         path,
//         i,
//         scen;

//     var test = (() {
//       var testId = 0;

//       return (startX, startY, endX, endY, grid, expectedLength,
//           expectedCostLength) {
//         it('should solve maze ${++testId}', () {
//           path = finder.findPath(startX, startY, endX, endY, grid);
//           if (optimal) {
//             if (useCost && expectedCostLength != null)
//               expect(path.length, expectedCostLength);
//             else
//               expect(path.length, expectedLength);
//           } else {
//             expect(path[0], [startX, startY]);
//             expect(path[path.length - 1], [endX, endY]);
//           }
//         });
//       };
//     })();

//     // Load all the scenarios and test against the finder.
//     for (i = 0; i < scenarios.length; ++i) {
//       scen = scenarios[i];

//       matrix = scen['matrix'];
//       costs = useCost ? scen['costs'] : null;
//       height = matrix.length;
//       width = matrix[0].length;

//       grid = new Grid(width, height, matrix, costs);

//       test(scen['startX'], scen['startY'], scen['endX'], scen['endY'], grid,
//           scen['expectedLength'], scen['expectedCostLength']);
//     }
//   });
// }

// pathTests(tests) {
//   for (var i = 0; i < tests.length; ++i) {
//     pathTest(tests[i]['name'], tests[i]['finder'], tests[i]['optimal'],
//         tests[i]['useCost']);
//   }
// }

// main() {
//   // finders guaranteed to find the shortest path
//   pathTests([
//     {
//       'name': 'AStar',
//       'finder': new AStarFinder(),
//       'optimal': true,
//       'useCost': false,
//     },
//     {
//       'name': 'AStar Cost',
//       'finder': new AStarFinder(),
//       'optimal': true,
//       'useCost': true,
//     }
//     /*, {
//     'name': 'BreadthFirst',
//     'finder': new PF.BreadthFirstFinder(),
//     'optimal': true,
//     'useCost': false,
//   }, {
//     'name': 'Dijkstra',
//     'finder': new PF.DijkstraFinder(),
//     'optimal': true,
//     'useCost': false,
//   }, {
//     'name': 'BiBreadthFirst',
//     'finder': new PF.BiBreadthFirstFinder(),
//     'optimal': true,
//     'useCost': false,
//   }, {
//     'name': 'BiDijkstra',
//     'finder': new PF.BiDijkstraFinder(),
//     'optimal': true,
//     'useCost': false,
//   }*/
//   ]);

//   // finders NOT guaranteed to find the shortest path
//   pathTests([
//     /*
//   {
//     'name': 'BiAStar',
//     'finder': new PF.BiAStarFinder(),
//     'optimal': false,
//     'useCost': false,
//   }, {
//     'name': 'BestFirst',
//     'finder': new PF.BestFirstFinder(),
//     'optimal': false,
//     'useCost': false,
//   }, {
//     'name': 'BiBestFirst',
//     'finder': new PF.BiBestFirstFinder(),
//     'optimal': false,
//     'useCost': false,
//   },*/
//     {
//       'name': 'JumpPoint',
//       'finder': new JumpPointFinder(),
//       'optimal': false,
//       'useCost': false,
//     }
//   ]);
// }
