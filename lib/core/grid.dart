library pathfinding.core.grid;

import 'node.dart';

/// The Grid class, which serves as the encapsulation of the layout of the nodes.
/// @constructor
/// @param {number} width Number of columns of the grid.
/// @param {number} height Number of rows of the grid.
/// @param {Array.<Array.<(number|boolean)>>} [matrix] - A 0-1 matrix
///     representing the walkable status of the nodes(0 or false for walkable).
///     If the matrix is not supplied, all the nodes will be walkable.
/// @param {Array.<Array.<(number)>>} [costs] - A matrix
///     representing the cost of walking the node.
///     If the costs is not supplied, all the nodes will cost 0.
/// */
class Grid {
  int width;
  int height;
  List<List<Node>> nodes = [];

  Grid(
    this.width,
    this.height, [
    List<List<int>> matrix = const <List<int>>[],
    List<List<int>> costs = const [],
  ]) {
    /**
     * The number of columns of the grid.
     * @type number
     */
    // this.width = width;
    /**
     * The number of rows of the grid.
     * @type number
     */
    // this.height = height;

    /**
     * A 2D array of nodes.
     */
    nodes = _buildNodes(width, height, matrix, costs);
  }

  /// Build and return the nodes.
  /// @private
  /// @param {number} width
  /// @param {number} height
  /// @param {Array.<Array.<number|boolean>>} [matrix] - A 0-1 matrix representing
  ///     the walkable status of the nodes.
  /// @param {Array.<Array.<number>>} [costs] - A matrix representing
  ///     the costs to walk the nodes.
  /// @see Grid
  List<List<Node>> _buildNodes(
      int width, int height, List<List<int>> matrix, List<List<int>> costs) {
    int i = 0;
    int j = 0;
    final List<List<Node>> nodes = List.filled(height, []);
    // int row = 0;

    for (i = 0; i < height; ++i) {
      nodes[i] = List.generate(width, (int i) => Node(0, 0));
      for (j = 0; j < width; ++j) {
        nodes[i][j] = Node(j, i);
        nodes[i][j].walkable = true;
      }
    }

    // if (matrix == null) {
    //   return nodes;
    // }

    if (matrix.length != height || matrix[0].length != width) {
      throw Exception('Matrix size does not fit');
    }

    if (costs.length != height || costs[0].length != width) {
      throw Exception('Costs size does not fit');
    }

    for (i = 0; i < height; ++i) {
      for (j = 0; j < width; ++j) {
        if (matrix[i][j] == 1) {
          // 0, false, null will be walkable
          // while others will be un-walkable
          nodes[i][j].walkable = false;
        }

        nodes[i][j].cost = costs[i][j];
      }
    }

    return nodes;
  }

  Node getNodeAt(int x, int y) {
    return nodes[y][x];
  }

  /// Determine whether the node at the given position is walkable.
  /// (Also returns false if the position is outside the grid.)
  /// @param {number} x - The x coordinate of the node.
  /// @param {number} y - The y coordinate of the node.
  /// @return {boolean} - The walkability of the node.
  bool isWalkableAt(int x, int y) {
    return isInside(x, y) && nodes[y][x].walkable;
  }

  /// Get cost to walk the node at the given position.
  /// (Also returns false if the position is outside the grid.)
  /// @param {number} x - The x coordinate of the node.
  /// @param {number} y - The y coordinate of the node.
  /// @return {number} - Cost to walk node.
  int getCostAt(int x, int y) {
    if (!isInside(x, y)) return 0;
    return nodes[y][x].cost;
  }

  /// Set cost of the node on the given position
  /// NOTE: throws exception if the coordinate is not inside the grid.
  /// @param {number} x - The x coordinate of the node.
  /// @param {number} y - The y coordinate of the node.
  /// @param {number} cost - Cost to walk the node.
  Future<void> setCostAt(int x, int y, int cost) async =>
      nodes[y][x].cost = cost;

  /// Determine whether the position is inside the grid.
  /// XXX: `grid.isInside(x, y)` is wierd to read.
  /// It should be `(x, y) is inside grid`, but I failed to find a better
  /// name for this method.
  /// @param {number} x
  /// @param {number} y
  /// @return {boolean}
  bool isInside(int x, int y) {
    return (x >= 0 && x < width) && (y >= 0 && y < height);
  }

  /// Set whether the node on the given position is walkable.
  /// NOTE: throws exception if the coordinate is not inside the grid.
  /// @param {number} x - The x coordinate of the node.
  /// @param {number} y - The y coordinate of the node.
  /// @param {boolean} walkable - Whether the position is walkable.
  void setWalkableAt(int x, int y, {bool walkable = true}) {
    nodes[y][x].walkable = walkable;
  }

  /// Get the neighbors of the given node.
  ///
  ///     offsets      diagonalOffsets:
  ///  +---+---+---+    +---+---+---+
  ///  |   | 0 |   |    | 0 |   | 1 |
  ///  +---+---+---+    +---+---+---+
  ///  | 3 |   | 1 |    |   |   |   |
  ///  +---+---+---+    +---+---+---+
  ///  |   | 2 |   |    | 3 |   | 2 |
  ///  +---+---+---+    +---+---+---+
  ///
  ///  When allowDiagonal is true, if offsets[i] is valid, then
  ///  diagonalOffsets[i] and
  ///  diagonalOffsets[(i + 1) % 4] is valid.
  /// @param {Node} node
  /// @param {boolean} allowDiagonal
  /// @param {boolean} dontCrossCorners
  List<Node> getNeighbors(Node node,
      {bool allowDiagonal = false, bool dontCrossCorners = false}) {
    final int x = node.x;
    final int y = node.y;
    final List<Node> neighbors = [];
    bool s0 = false;
    bool d0 = false;
    bool s1 = false;
    bool d1 = false;
    bool s2 = false;
    bool d2 = false;
    bool s3 = false;
    bool d3 = false;
    final nodes = this.nodes;

    // ↑
    if (isWalkableAt(x, y - 1)) {
      neighbors.add(nodes[y - 1][x]);
      s0 = true;
    }
    // →
    if (isWalkableAt(x + 1, y)) {
      neighbors.add(nodes[y][x + 1]);
      s1 = true;
    }
    // ↓
    if (isWalkableAt(x, y + 1)) {
      neighbors.add(nodes[y + 1][x]);
      s2 = true;
    }
    // ←
    if (isWalkableAt(x - 1, y)) {
      neighbors.add(nodes[y][x - 1]);
      s3 = true;
    }

    if (!allowDiagonal) {
      return neighbors;
    }

    if (dontCrossCorners) {
      d0 = s3 && s0;
      d1 = s0 && s1;
      d2 = s1 && s2;
      d3 = s2 && s3;
    } else {
      d0 = s3 || s0;
      d1 = s0 || s1;
      d2 = s1 || s2;
      d3 = s2 || s3;
    }

    // ↖
    if (d0 && isWalkableAt(x - 1, y - 1)) {
      neighbors.add(nodes[y - 1][x - 1]);
    }
    // ↗
    if (d1 && isWalkableAt(x + 1, y - 1)) {
      neighbors.add(nodes[y - 1][x + 1]);
    }
    // ↘
    if (d2 && isWalkableAt(x + 1, y + 1)) {
      neighbors.add(nodes[y + 1][x + 1]);
    }
    // ↙
    if (d3 && isWalkableAt(x - 1, y + 1)) {
      neighbors.add(nodes[y + 1][x - 1]);
    }

    return neighbors;
  }

  /// Get a clone of this grid.
  /// @return {Grid} Cloned grid.
  Grid clone() {
    int i = 0;
    int j = 0;
    // width = this.width;
    // height = this.height,
    final List<List<Node>> thisNodes = nodes;
    final Grid newGrid = Grid(width, height);
    // final List<List<int>> newNodes = List(height);
    final List<List<Node>> newNodes = List.generate(height, (int z) => []);
    // int row;

    for (i = 0; i < height; ++i) {
      newNodes[i] = List.generate(width, (int z) => Node(0, 0));
      for (j = 0; j < width; ++j) {
        newNodes[i][j] = Node(j, i,
            walkable: thisNodes[i][j].walkable, cost: thisNodes[i][j].cost);
      }
    }

    newGrid.nodes = newNodes;

    return newGrid;
  }
}
