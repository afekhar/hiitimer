import 'dart:async';

import 'package:flutter/material.dart';

import 'package:hiitimer/dots.dart';
import 'package:hiitimer/double_digits.dart';
import 'package:hiitimer/beep_manager.dart';

class DigitalTimer extends StatefulWidget {
  const DigitalTimer(
      {super.key,
      required this.targetInSeconds,
      required this.onEnd,
      this.setup = false});

  final int targetInSeconds;
  final Function onEnd;
  final bool setup;

  @override
  State<DigitalTimer> createState() => _DigitalTimerState();
}

class _DigitalTimerState extends State<DigitalTimer> {
  int _seconds = 0;
  int _minutes = 0;

  final beepManager = BeepManager(
    shortBeepPath: 'sounds/beep_short.mp3',
    longBeepPath: 'sounds/beep_long.mp3',
  );

  _setUpTimer() {
    int count = 0;

    setState(() {
      _seconds = count % 60;
      _minutes = count ~/ 60;
    });

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if ((count++) < widget.targetInSeconds) {
        setState(() {
          _seconds = count % 60;
          _minutes = count ~/ 60;
        });

        if (count == widget.targetInSeconds) {
          beepManager.playLong();
        } else if (count > widget.targetInSeconds - 4) {
          beepManager.playShort();
        }
      } else {
        timer.cancel();
        widget.onEnd();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _setUpTimer();
  }

  @override
  void didUpdateWidget(covariant DigitalTimer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.targetInSeconds != widget.targetInSeconds) {
      _setUpTimer();
    }
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
            Opacity(
                opacity: widget.setup ? 0.0 : 1.0,
                child: DoubleDigits(
                    color: "green", number: _minutes, displayRatio: ratio)),
            Opacity(
                opacity: widget.setup ? 0.0 : 1.0,
                child: DigitalTimerDots(color: "green", displayRatio: ratio)),
            DoubleDigits(
                color: widget.setup ? "red" : "green",
                number: _seconds,
                displayRatio: ratio),
          ],
        );
      },
    );
  }
}
