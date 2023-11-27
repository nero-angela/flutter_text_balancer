import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.title,
    required this.child,
    this.titlePadding,
    this.crossAxisAlignment,
  });
  final String title;
  final Widget child;
  final EdgeInsets? titlePadding;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        Padding(
          padding: titlePadding ?? const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
