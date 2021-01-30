import '../core/grid.dart';

abstract class Finder {
  List<List<int>> findPath(
      int startX, int startY, int endX, int endY, Grid grid);
}
