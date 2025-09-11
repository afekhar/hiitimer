import 'package:flutter/material.dart';

class DoubleDigits extends StatefulWidget {
  const DoubleDigits(
      {super.key,
      required this.color,
      required this.number,
      required this.displayRatio});

  final String color;
  final int number;
  final double displayRatio;

  static int width = 400 * 2;
  static int height = 611;

  @override
  State<DoubleDigits> createState() => _DoubleDigitsState();
}

class _DoubleDigitsState extends State<DoubleDigits> {
  @override
  void didChangeDependencies() {
    for (final digit in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]) {
      precacheImage(
          AssetImage('assets/images/digits/${widget.color}/$digit.png'),
          context);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final dOnes = widget.number % 10;
    final dTens = (widget.number ~/ 10) % 10;

    return Row(
      children: [
        Image.asset(
          'assets/images/digits/${widget.color}/$dTens.png',
          width: (DoubleDigits.width / 2) * widget.displayRatio,
          height: DoubleDigits.height * widget.displayRatio,
        ),
        Image.asset(
          'assets/images/digits/${widget.color}/$dOnes.png',
          width: (DoubleDigits.width / 2) * widget.displayRatio,
          height: DoubleDigits.height * widget.displayRatio,
        ),
      ],
    );
  }
}
