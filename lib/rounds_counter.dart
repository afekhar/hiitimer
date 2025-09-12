import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:hiitimer/double_digits.dart';
import 'package:hiitimer/theme.dart';

class RoundsCounter extends StatelessWidget {
  const RoundsCounter({super.key, required this.round});

  final int round;

  @override
  Widget build(BuildContext context) {
    final int counterWidth = DoubleDigits.width;
    final int counterHeight = DoubleDigits.height;

    return LayoutBuilder(builder: (context, constraints) {
      final double widthRatio = constraints.maxWidth / counterWidth;
      final double heightRatio = constraints.maxHeight / counterHeight;

      final double ratio = widthRatio < heightRatio ? widthRatio : heightRatio;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: (DoubleDigits.width / 2) * ratio,
            height: (DoubleDigits.height / 2) * ratio,
            child: FittedBox(
              fit: BoxFit.scaleDown, // réduit la taille si nécessaire
              alignment: Alignment.centerLeft, // ou center, right, etc.
              child: Text(
                "Tour :",
                style: TextStyle(
                  fontSize: 100,
                  fontFamily: "BalooTamma2",
                  fontWeight: FontWeight.w700,
                  color: primary700,
                ), // taille max
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: DoubleDigits(
              color: "red",
              number: round,
              displayRatio: ratio,
            ),
          ),
        ],
      );
    });
  }
}
