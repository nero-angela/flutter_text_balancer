import 'package:example/widget/section.dart';
import 'package:example/widget/tile.dart';
import 'package:flutter/material.dart';

class FontSizeSlider extends StatelessWidget {
  const FontSizeSlider({
    super.key,
    required this.fontSizeNoti,
  });

  final ValueNotifier<double> fontSizeNoti;

  @override
  Widget build(BuildContext context) {
    return Tile(
      child: ValueListenableBuilder(
        valueListenable: fontSizeNoti,
        builder: (context, value, child) => Section(
          title: 'Font Size',
          titlePadding: const EdgeInsets.only(),
          crossAxisAlignment: CrossAxisAlignment.start,
          child: Slider(
            value: value,
            onChanged: (v) {
              fontSizeNoti.value = v;
            },
          ),
        ),
      ),
    );
  }
}
