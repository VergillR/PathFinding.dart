library pathfinding.core.node;

/// A node in grid.
/// This class holds some basic information about a node and custom
/// attributes may be added, depending on the algorithms' needs.
/// @constructor
/// @param {number} x - The x coordinate of the node on the grid.
/// @param {number} y - The y coordinate of the node on the grid.
/// @param {boolean} [walkable] - Whether this node is walkable.
/// @param {number} [cost] - Node cost used by finders that allow non-uniform node costs.
class Node {
  /// The x coordinate of the node on the grid.
  /// @type number
  int x;

  /// The y coordinate of the node on the grid.
  /// @type number
  int y;

  /// Whether this node can be walked through.
  /// @type boolean
  bool walkable;

  /// Cost to walk this node if its walkable
  /// @type number
  int cost;

  // TODO: this is a hack...
  int g = 0;
  int h = -1;
  int f = 0;
  bool opened = true;
  bool closed = true;
  Node? parent;

  Node(this.x, this.y, {this.walkable = true, this.cost = 0});

  @override
  String toString() => 'Node[$x,$y]';
}
