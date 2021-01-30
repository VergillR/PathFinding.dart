library pathfinding.core.heap;

// From https://github.com/qiao/heap.js

// import 'dart:math';
import './node.dart';

int defaultCmp(dynamic x, dynamic y) {
  if (x is int && y is int) {
    if (x < y) {
      return -1;
    }
    if (x > y) {
      return 1;
    }
  }
  return 0;
}

/// Insert item x in list a, and keep it sorted assuming a is sorted.
/// If x is already in a, insert it to the right of the rightmost x.
/// Optional args lo (default 0) and hi (default a.length) bound the slice
/// of a to be searched.
// void _insort(
//     List<int> a, int x, int low, int high, int Function(int, int) cmp) {
//   int lo = low;
//   int hi = high;
//   int mid = 0;
//   // if (lo == null) {
//   //   lo = 0;
//   // }
//   // if (cmp == null) {
//   //   cmp = defaultCmp;
//   // }
//   if (lo < 0) {
//     throw Exception('lo must be non-negative');
//   }
//   // if (hi == null) {
//   //   hi = a.length;
//   // }
//   while (cmp(lo, hi) < 0) {
//     mid = ((lo + hi) / 2).floor();
//     if (cmp(x, a[mid]) < 0) {
//       hi = mid;
//     } else {
//       lo = mid + 1;
//     }
//   }
//   a.insert(lo, x);
// }

/// Push item onto heap, maintaining the heap invariant.
Node _heappush(
    List<Node> array, Node item, int Function(dynamic, dynamic) cmp) {
  // if (cmp == null) {
  //   cmp = defaultCmp;
  // }
  array.add(item);
  return _siftdown(array, 0, array.length - 1, cmp);
}

/// Pop the smallest item off the heap, maintaining the heap invariant.
Node _heappop(List<Node> array, int Function(dynamic, dynamic) cmp) {
  Node returnitem = Node(0, 0);
  // if (cmp == null) {
  //   cmp = defaultCmp;
  // }
  final Node lastelt = array.removeLast();
  if (array.isNotEmpty) {
    returnitem = array[0];
    array[0] = lastelt;
    _siftup(array, 0, cmp);
  } else {
    returnitem = lastelt;
  }
  return returnitem;
}

/// Pop and return the current smallest value, and add the new item.
///
/// This is more efficient than heappop() followed by heappush(), and can be
/// more appropriate when using a fixed size heap. Note that the value
/// returned may be larger than item! That constrains reasonable use of
/// this routine unless written as part of a conditional replacement:
///   if item > array[0]
///     item = heapreplace(array, item)
Node _heapreplace(
    List<Node> array, Node item, int Function(dynamic, dynamic) cmp) {
  // Node returnitem;
  // if (cmp == null) {
  //   cmp = defaultCmp;
  // }
  final Node returnitem = array[0];
  array[0] = item;
  _siftup(array, 0, cmp);
  return returnitem;
}

/// Fast version of a heappush followed by a heappop.
Node _heappushpop(
    List<Node> array, Node item, int Function(dynamic, dynamic) cmp) {
  // Node _ref = Node(0, 0);
  // if (cmp == null) {
  //   cmp = defaultCmp;
  // }
  Node res = item;
  if (array.isNotEmpty && cmp(array[0], res) < 0) {
    final List<Node> _ref = [array[0], res];
    res = _ref[0];
    array[0] = _ref[1];
    _siftup(array, 0, cmp);
  }
  return res;
}

/// Transform list into a heap, in-place, in O(array.length) time.
List<Node> _heapify(List<Node> array, int Function(dynamic, dynamic) cmp) {
  int i = 0;
  int _i = 0;
  int _len = 0;

  List<int> _ref1 = <int>[];
  // if (cmp == null) {
  //   cmp = defaultCmp;
  // }
  final List<Node> _results = <Node>[];
  final List<int> _results1 = <int>[];
  final int _ref = (array.length / 2).floor();
  for (int _j = 0; 0 <= _ref ? _j < _ref : _j > _ref; 0 <= _ref ? _j++ : _j--) {
    _results1.add(_j);
  }
  _ref1 = _results1.reversed.toList();
  // _results = [];
  _i = 0;
  for (_len = _ref1.length; _i < _len; _i++) {
    i = _ref1[_i];
    _results.add(_siftup(array, i, cmp));
  }
  return _results;
}

/// Update the position of the given item in the heap.
/// This function should be called every time the item is being modified.
Node _updateItem(
    List<Node> array, Node item, int Function(dynamic, dynamic) cmp) {
  // var pos;
  // if (cmp == null) {
  //   cmp = defaultCmp;
  // }
  final int pos = array.indexOf(item);
  _siftdown(array, 0, pos, cmp);
  return _siftup(array, pos, cmp);
}

// /**
//  * Find the n largest elements in a dataset.
//  */
// _nlargest(array, n, cmp) {
//   var elem, result, _i, _len, _ref;
//   if (cmp == null) {
//     cmp = defaultCmp;
//   }
//   result = array.slice(0, n);
//   if (!result.length) {
//     return result;
//   }
//   _heapify(result, cmp);
//   _ref = array.slice(n);
//   _i = 0;
//   for (_len = _ref.length; _i < _len; _i++) {
//     elem = _ref[_i];
//     _heappushpop(result, elem, cmp);
//   }
//   return result.sort(cmp).reverse();
// }

// /**
//  * Find the n smallest elements in a dataset.
//  */
// _nsmallest(array, n, cmp) {
//   var elem, i, los, result, _i, _j, _len, _ref, _ref1, _results;
//   if (cmp == null) {
//     cmp = defaultCmp;
//   }
//   if (n * 10 <= array.length) {
//     result = array.slice(0, n).sort(cmp);
//     if (!result.length) {
//       return result;
//     }
//     los = result[result.length - 1];
//     _ref = array.slice(n);
//     _i = 0;
//     for (_len = _ref.length; _i < _len; _i++) {
//       elem = _ref[_i];
//       if (cmp(elem, los) < 0) {
//         _insort(result, elem, 0, null, cmp);
//         result.removeLast();
//         los = result[result.length - 1];
//       }
//     }
//     return result;
//   }
//   _heapify(array, cmp);
//   _results = [];
//   i = _j = 0;
//   for (_ref1 = min<num>(n, array.length);
//       0 <= _ref1 ? _j < _ref1 : _j > _ref1;
//       i = 0 <= _ref1 ? ++_j : --_j) {
//     _results.push(_heappop(array, cmp));
//   }
//   return _results;
// }

Node _siftdown(List<Node> array, int startpos, int pos,
    int Function(dynamic, dynamic) cmp) {
  int p = pos;
  final Node newitem = array[pos];
  Node parent = Node(0, 0);
  int parentpos = 0;
  // if (cmp == null) {
  //   cmp ??= defaultCmp;
  // }
  // newitem = array[pos];
  while (p > startpos) {
    parentpos = (p - 1) >> 1;
    parent = array[parentpos];
    if (cmp(newitem, parent) < 0) {
      array[p] = parent;
      p = parentpos;
      continue;
    }
    break;
  }
  return array[p] = newitem;
}

Node _siftup(List<Node> array, int pos, int Function(dynamic, dynamic) cmp) {
  // if (cmp == null) {
  //   cmp = defaultCmp;
  // }
  final int endpos = array.length;
  final int startpos = pos;
  final Node newitem = array[pos];
  int childpos = 2 * pos + 1;
  int rightpos = childpos + 1;
  int p = pos;
  while (childpos < endpos) {
    rightpos = childpos + 1;
    if (rightpos < endpos && !(cmp(array[childpos], array[rightpos]) < 0)) {
      childpos = rightpos;
    }
    array[p] = array[childpos];
    p = childpos;
    childpos = 2 * p + 1;
  }
  array[p] = newitem;
  return _siftdown(array, startpos, p, cmp);
}

class Heap {
  int Function(dynamic, dynamic) cmp;
  List<Node> nodes;

  Heap([this.cmp = defaultCmp]) : nodes = <Node>[];
  // {
  //   // this.cmp = cmp != null ? cmp : defaultCmp;
  //   nodes = <Node>[];
  // }

  Node push(Node x) {
    return _heappush(nodes, x, cmp);
  }

  Node insert(Node x) {
    return push(x);
  }

  Node pop() {
    return _heappop(nodes, cmp);
  }

  Node remove() => pop();

  Node peek() {
    return nodes[0];
  }

  Node top() => peek();
  Node front() => peek();

  bool contains(Node x) {
    return nodes.contains(x);
  }

  bool has(Node x) => contains(x);

  Node replace(Node x) {
    return _heapreplace(nodes, x, cmp);
  }

  Node pushpop(Node x) {
    return _heappushpop(nodes, x, cmp);
  }

  List<Node> heapify() {
    return _heapify(nodes, cmp);
  }

  Node updateItem(Node x) {
    return _updateItem(nodes, x, cmp);
  }

  void clear() {
    return nodes.clear();
  }

  bool empty() {
    return nodes.isEmpty;
  }

  int size() {
    return nodes.length;
  }

  Heap clone() {
    final heap = Heap(cmp);
    heap.nodes = List<Node>.from(nodes);
    return heap;
  }

  Heap copy() => clone();

  List<int> toArray() {
    return List<int>.from(nodes);
  }
}
