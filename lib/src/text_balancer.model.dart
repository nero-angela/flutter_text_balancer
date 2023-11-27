part of '../text_balancer.dart';

/// Proportional font divide algorithm
String balanced(
  String text, {
  required TextStyle textStyle,
  required double maxWidth,
  int? minLines,
}) {
  final result = _balancedByDp(
    text,
    textStyle,
    maxWidth,
    minLines ?? 1,
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

/// Time complexity : n^2
List<String> _balancedByDp(
  final String text,
  final TextStyle textStyle,
  final double maxWidth,
  final int minLines,
) {
  double width = maxWidth;
  final double space = _getTextWidth(' ', textStyle);
  final List<String> words = text.split(' ');
  final List<double> wordWidthList = words.map((w) {
    return _getTextWidth(w, textStyle);
  }).toList();
  int count = words.length;
  if (count <= minLines) {
    return words;
  }
  final double textWidth = _getTextWidth(text, textStyle);
  final int nLines = (textWidth / width).ceil();
  if (nLines < minLines && minLines > 1) {
    width = textWidth / (minLines - 0.99);
  }

  List<List<double>> slack = List.generate(count, (i) => List.filled(count, 0));
  for (int i = 0; i < count; i++) {
    slack[i][i] = width - wordWidthList[i];
    for (int j = i + 1; j < count; j++) {
      slack[i][j] = slack[i][j - 1] - wordWidthList[j] - space;
    }
  }

  List<double> minima = [0.0] + List.filled(count, double.infinity);
  List<int> breaks = List.filled(count, 0);

  for (int j = 0; j < count; j++) {
    int i = j;
    while (i >= 0) {
      double cost = (slack[i][j] < 0)
          ? double.infinity
          : minima[i] + slack[i][j] * slack[i][j];
      if (minima[j + 1] > cost) {
        minima[j + 1] = cost;
        breaks[j] = i;
      }
      i -= 1;
    }
  }

  List<String> lines = [];
  int j = count;
  while (j > 0) {
    int i = breaks[j - 1];
    lines.add(words.sublist(i, j).join(' '));
    j = i;
  }
  lines = lines.reversed.toList();
  return lines;
}
