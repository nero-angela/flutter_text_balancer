part of '../text_balancer.dart';

extension TextBalancerStringExt on String {
  String balance({
    required TextStyle textStyle,
    required double maxWidth,
  }) {
    return balanced(this, textStyle: textStyle, maxWidth: maxWidth);
  }
}

extension TextBalancerTextExt on Text {
  Text balance(
    BuildContext context, {
    double? maxWidth,
  }) {
    assert(data != null);
    final textStyle = style ?? DefaultTextStyle.of(context).style;
    final width = maxWidth ?? MediaQuery.of(context).size.width;
    final balancedData = balanced(
      data!,
      textStyle: textStyle,
      maxWidth: width,
    );
    return Text(
      balancedData,
      key: key,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}
