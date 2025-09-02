import 'dart:async';

import 'package:flutter/material.dart';

import 'package:hiitimer/dots.dart';
import 'package:hiitimer/double_digits.dart';
import 'package:hiitimer/beep_manager.dart';

enum DigitalTimerStatus { playing, paused, stopped }

class DigitalTimerSeconds {
  const DigitalTimerSeconds({required this.seconds});

  final int seconds;
}

class DigitalTimer extends StatefulWidget {
  const DigitalTimer({
    super.key,
    required this.targetInSeconds,
    required this.onEnd,
    this.setup = false,
    this.status = DigitalTimerStatus.playing,
  });

  final DigitalTimerSeconds targetInSeconds;
  final Function onEnd;
  final bool setup;
  final DigitalTimerStatus status;

  @override
  State<DigitalTimer> createState() => _DigitalTimerState();
}

class _DigitalTimerState extends State<DigitalTimer> {
  int _seconds = 0;
  int _minutes = 0;

  int _count = 0;

  Timer? _timer;

  final beepManager = BeepManager(
    shortBeepPath: 'sounds/beep_short.mp3',
    longBeepPath: 'sounds/beep_long.mp3',
  );

  _stop() {
    _timer?.cancel();
    _count = widget.targetInSeconds.seconds;
  }

  _pause() {
    _timer?.cancel();
  }

  _replay() {
    _setUpTimer();
  }

  _setUpTimer() {
    setState(() {
      _seconds = _count % 60;
      _minutes = _count ~/ 60;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if ((--_count) >= 0) {
        setState(() {
          _seconds = _count % 60;
          _minutes = _count ~/ 60;
        });

        if (_count == 0) {
          beepManager.playLong();
        } else if (_count <= 3) {
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

    _count = widget.targetInSeconds.seconds;
    _setUpTimer();
  }

  @override
  void didUpdateWidget(covariant DigitalTimer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.targetInSeconds !=
        widget
            .targetInSeconds) // returns false if two different objects, even if their values (seconds) are the same.
    {
      _count = widget.targetInSeconds.seconds;
      _setUpTimer();
    }

    if(oldWidget.status != widget.status) {
      switch(widget.status) {
        case DigitalTimerStatus.playing:
          _replay();
          break;
        case DigitalTimerStatus.paused:
          _pause();
          break;
        case DigitalTimerStatus.stopped:
          _stop();
          break;
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
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
