library pathfinding.core.heuristic;

import 'dart:math';

typedef HeuristicFn = double Function(double dx, double dy);

class Heuristic {
  /// Manhattan distance.
  /// @param {number} dx - Difference in x.
  /// @param {number} dy - Difference in y.
  /// @return {number} dx + dy
  static double manhattan(double dx, double dy) {
    return dx + dy;
  }

  /// Euclidean distance.
  /// @param {number} dx - Difference in x.
  /// @param {number} dy - Difference in y.
  /// @return {number} sqrt(dx * dx + dy * dy)
  static double euclidean(double dx, double dy) {
    return sqrt(dx * dx + dy * dy);
  }

  /// Chebyshev distance.
  /// @param {number} dx - Difference in x.
  /// @param {number} dy - Difference in y.
  /// @return {number} max(dx, dy)
  static double chebyshev(double dx, double dy) {
    return max<double>(dx, dy);
  }
}
