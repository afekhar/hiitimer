import 'dart:async';

import 'package:flutter/material.dart';

import 'package:hiitimer/dots.dart';
import 'package:hiitimer/double_digits.dart';
import 'package:hiitimer/beep_manager.dart';

class DigitalTimer extends StatefulWidget {
  const DigitalTimer({
    super.key,
    required this.targetInSeconds,
  });

  final int targetInSeconds;

  @override
  State<DigitalTimer> createState() => _DigitalTimerState();
}

class _DigitalTimerState extends State<DigitalTimer> {
  int _count = 0;

  int _seconds = 0;
  int _minutes = 0;

  final beepManager = BeepManager(
    shortBeepPath: 'sounds/beep_short.mp3',
    longBeepPath: 'sounds/beep_long.mp3',
  );

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if ((_count++) < widget.targetInSeconds) {
        setState(() {
          _seconds = _count % 60;
          _minutes = _count ~/ 60;
        });

        if (_count == widget.targetInSeconds) {
          beepManager.playLong();
        } else if (_count > widget.targetInSeconds - 4) {
          beepManager.playShort();
        }
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    beepManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int timerWidth =
        DoubleDigits.width + DigitalTimerDots.width + DoubleDigits.width;
    final int timerHeight = DoubleDigits.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double widthRatio = constraints.maxWidth / timerWidth;
        final double heightRatio = constraints.maxHeight / timerHeight;

        final double ratio =
            widthRatio < heightRatio ? widthRatio : heightRatio;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DoubleDigits(color: "green", number: _minutes, displayRatio: ratio),
            DigitalTimerDots(color: "green", displayRatio: ratio),
            DoubleDigits(color: "green", number: _seconds, displayRatio: ratio),
          ],
        );
      },
    );
  }
}
