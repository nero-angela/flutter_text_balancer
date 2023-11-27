import 'package:example/widget/section.dart';
import 'package:example/widget/tile.dart';
import 'package:flutter/material.dart';

class MinLinesSlider extends StatelessWidget {
  const MinLinesSlider({
    super.key,
    required this.minLinesNoti,
  });

  final ValueNotifier<double> minLinesNoti;

  @override
  Widget build(BuildContext context) {
    return Tile(
      child: ValueListenableBuilder(
        valueListenable: minLinesNoti,
        builder: (context, value, child) => Section(
          title: 'Min Lines',
          titlePadding: const EdgeInsets.only(),
          crossAxisAlignment: CrossAxisAlignment.start,
          child: Slider(
            value: value.toDouble(),
            divisions: 3,
            label: '${value * 3 + 1}',
            onChanged: (v) {
              minLinesNoti.value = v;
            },
          ),
        ),
      ),
    );
  }
}
