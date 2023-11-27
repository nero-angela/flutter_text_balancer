part of '../text_balancer.dart';

String balanced(
  String text, {
  required TextStyle textStyle,
  required double maxWidth,
}) {
  final result = _devideProportionalFont(
    text,
    textStyle,
    maxWidth,
  );
  return result.join('\n');
}

double _getTextWidth(String text, TextStyle textStyle) {
  final textPainter = TextPainter(
    text: TextSpan(text: text, style: textStyle),
    textDirection: TextDirection.ltr,
  )..layout();
  return textPainter.width;
}

/// Proportional font divide algorithm
/// references : https://xxyxyz.org/line-breaking
List<String> _devideProportionalFont(
  String text,
  TextStyle textStyle,
  double maxWidth,
) {
  final space = _getTextWidth(' ', textStyle);
  final words = text.split(' ');
  final wordWidthList = words.map((w) {
    return _getTextWidth(w, textStyle);
  }).toList();
  int count = words.length;
  List<double> offsets = [0.0];
  for (int i = 0; i < words.length; i++) {
    offsets.add(offsets[offsets.length - 1] + wordWidthList[i]);
  }

  List<double> minima = [0.0] + List<double>.filled(count, double.infinity);
  List<int> breaks = List<int>.filled(count + 1, 0);

  double cost(int i, int j) {
    double w = offsets[j] - offsets[i] + (j - i - 1) * space;
    if (w > maxWidth) {
      return double.infinity;
    }
    return minima[i] + pow((maxWidth - w), 2);
  }

  void search(int i0, int j0, int i1, int j1) {
    List<List<int>> stack = [
      [i0, j0, i1, j1]
    ];
    while (stack.isNotEmpty) {
      List<int> args = stack.removeLast();
      i0 = args[0];
      j0 = args[1];
      i1 = args[2];
      j1 = args[3];
      if (j0 < j1) {
        int j = (j0 + j1) ~/ 2;
        for (int i = i0; i < i1; i++) {
          double c = cost(i, j);
          if (c <= minima[j]) {
            minima[j] = c;
            breaks[j] = i;
          }
        }
        stack.add([breaks[j], j + 1, i1, j1]);
        stack.add([i0, j0, breaks[j] + 1, j]);
      }
    }
  }

  int n = count + 1;
  int i = 0;
  int offset = 0;
  while (true) {
    int r = min(n, pow(2, (i + 1)).toInt());
    int edge = pow(2, i).toInt() + offset;

    search(0 + offset, edge, edge, r + offset);
    double x = minima[r - 1 + offset];
    for (int j = pow(2, i).toInt(); j < r - 1; j++) {
      double y = cost(j + offset, r - 1 + offset);
      if (y <= x) {
        n -= j;
        i = 0;
        offset += j;
        break;
      }
    }
    if (r == n) {
      break;
    }
    i = i + 1;
  }

  List<String> lines = [];
  int j = count;
  while (j > 0) {
    int i = breaks[j];
    lines.add(words.sublist(i, j).join(' '));
    j = i;
  }
  lines = List.from(lines.reversed);
  return lines;
}
