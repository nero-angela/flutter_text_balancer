import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    this.width,
    this.child,
  });

  final double? width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            offset: Offset(0, 3),
            blurRadius: 8,
          ),
          BoxShadow(
            color: Color(0x0A000000),
            offset: Offset(0, 3),
            blurRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}
