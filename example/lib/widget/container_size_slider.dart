import 'package:example/widget/section.dart';
import 'package:example/widget/tile.dart';
import 'package:flutter/material.dart';

class ContainerSizeSlider extends StatelessWidget {
  const ContainerSizeSlider({
    super.key,
    required this.containerWidthNoti,
  });

  final ValueNotifier<double> containerWidthNoti;

  @override
  Widget build(BuildContext context) {
    return Tile(
      child: ValueListenableBuilder(
        valueListenable: containerWidthNoti,
        builder: (context, value, child) => Section(
          title: 'Container Size',
          titlePadding: const EdgeInsets.only(),
          crossAxisAlignment: CrossAxisAlignment.start,
          child: Slider(
            value: value,
            onChanged: (v) {
              containerWidthNoti.value = v;
            },
          ),
        ),
      ),
    );
  }
}
