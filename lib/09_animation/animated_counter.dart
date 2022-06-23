import 'package:flutter/material.dart';

class AnimatedCounter extends StatelessWidget {
  final int value;
  final Duration duration;

  const AnimatedCounter({Key? key, required this.value, required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: duration,
      tween: Tween(end: value.toDouble()),
      builder: (BuildContext context, double v, Widget? child) {
        final whole = v ~/ 1; // 获得整数部分
        final decimal = v - whole; // 获得小数部分
        return Stack(
          children: [
            Positioned(
              top: -100.0 * decimal, // 0 → - 100
              child: Opacity(
                opacity: 1.0 - decimal, // 1 → 0
                child: Text(
                  "$whole",
                  style: const TextStyle(fontSize: 100),
                ),
              ),
            ),
            Positioned(
              top: 100 - decimal * 100, // 100 → 0
              child: Opacity(
                opacity: decimal + 0.0, // 0 → 1
                child: Text(
                  "${whole + 1}",
                  style: const TextStyle(fontSize: 100),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
