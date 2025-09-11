import 'package:flutter/material.dart';
import 'package:hiitimer/rounds_setter.dart';

import 'package:hiitimer/theme.dart';

class TimerConfigRounds extends StatelessWidget {
  const TimerConfigRounds({super.key, required this.rounds, required this.onRoundsChange});

  final int rounds;
  final Function(int) onRoundsChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: primary200,
          isScrollControlled:
              true, // Necessary to avoid the error: BOTTOM OVERFLOW BY XX PIXELS
          builder: (context) => SafeArea(
            top: false,
            child: IntrinsicHeight(
              // Makes the bottom sheet fit its content height
              child: RoundsSetter(
                rounds: rounds,
                onCancel: () => Navigator.of(context).pop(),
                onOK: (newCount) {
                  onRoundsChange(newCount);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: primary500,
        ),
        child: Text(
          'x$rounds rounds',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
              color: primary900),
        ),
      ),
    );
  }
}
