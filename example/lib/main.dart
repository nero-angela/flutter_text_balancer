import 'package:example/widget/container_size_slider.dart';
import 'package:example/widget/font_size_slider.dart';
import 'package:example/widget/min_lines_slider.dart';
import 'package:example/widget/section.dart';
import 'package:example/widget/tile.dart';
import 'package:flutter/material.dart';
import 'package:text_balancer/text_balancer.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const ExamplePage(),
    ),
  );
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  bool isKorean = false;
  String get text => isKorean
      ? "Flutter는 전체 앱 개발 프로세스를 변화시킵니다."
      : "Flutter transforms the entire app development process.";
  final ValueNotifier<double> containerWidthNoti = ValueNotifier(1);
  final ValueNotifier<double> fontSizeNoti = ValueNotifier(0.5);
  final ValueNotifier<double> minLinesNoti = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextBalancer'),
        actions: [
          /// Toggle language buton
          TextButton(
            onPressed: () {
              setState(() {
                isKorean = !isKorean;
              });
            },
            child: Text(isKorean ? 'EN' : 'KO'),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => ValueListenableBuilder(
                    valueListenable: containerWidthNoti,
                    builder: (context, value, child) {
                      final double maxWidth = constraints.maxWidth;
                      return Tile(
                        width: (1 + value) * maxWidth / 2,
                        child: child,
                      );
                    },
                    child: ValueListenableBuilder(
                      valueListenable: fontSizeNoti,
                      builder: (context, value, child) => DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 12 * (1 + 3 * value),
                          color: Colors.black,
                        ),
                        child: child!,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            /// [Text]
                            Section(
                              title: 'Default',
                              child: Text(text),
                            ),
                            const SizedBox(height: 32),

                            /// [TextBalancer]
                            Section(
                              title: 'Text Balancer',
                              child: ValueListenableBuilder(
                                valueListenable: minLinesNoti,
                                builder: (context, v, child) {
                                  final minLines = (v * 3 + 1).toInt();
                                  return TextBalancer(
                                    text,
                                    minLines: minLines,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              /// Container Size Slider
              ContainerSizeSlider(containerWidthNoti: containerWidthNoti),
              const SizedBox(height: 12),

              /// Font Size Slider
              FontSizeSlider(fontSizeNoti: fontSizeNoti),
              const SizedBox(height: 12),

              /// Min Lines Slider
              MinLinesSlider(minLinesNoti: minLinesNoti),
            ],
          ),
        ),
      ),
    );
  }
}
