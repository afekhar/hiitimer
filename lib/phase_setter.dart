import 'package:flutter/material.dart';

import 'package:hiitimer/theme.dart';
import 'package:hiitimer/digits_keyboard.dart';

class PhaseSetter extends StatefulWidget {
  const PhaseSetter({
    super.key,
    required this.seconds,
    required this.onCancel,
    required this.onOK,
  });

  final int seconds;
  final Function onCancel;
  final Function(int) onOK;

  @override
  State<PhaseSetter> createState() => _PhaseSetterState();
}

class _PhaseSetterState extends State<PhaseSetter> {
  int _ms = -1;

  digitTapped(DigitKey? code) {
    if (code != null) {
      if ([
        DigitKey.zero,
        DigitKey.one,
        DigitKey.two,
        DigitKey.three,
        DigitKey.four,
        DigitKey.five,
        DigitKey.six,
        DigitKey.seven,
        DigitKey.eight,
        DigitKey.nine,
        DigitKey.doubeZero,
      ].contains(code)) {
        final int ms = (code == DigitKey.doubeZero)
            ? _ms * 100
            : _ms * 10 + keyToNum(code);

        if (ms <= 9999) {
          setState(() {
            _ms = ms;
          });
        }
      } else if (code == DigitKey.backspace) {
        setState(() {
          _ms = _ms ~/ 10;
        });
      } else if (code == DigitKey.cancel) {
        widget.onCancel();
      } else if (code == DigitKey.ok) {
        int seconds = _ms % 100;
        int minutes = _ms ~/ 100;

        if (seconds < 60 && minutes < 60) {
          widget.onOK((minutes * 60) + seconds);
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Format de temps invalide"),
              content: const Text(
                "Les secondes et les minutes doivent être comprises entre 0 et 59.",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();

    int seconds = widget.seconds % 60;
    int minutes = widget.seconds ~/ 60;

    setState(() {
      _ms = (minutes * 100) + seconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    int seconds = _ms % 100;
    int minutes = _ms ~/ 100;

    return DefaultTextStyle(
      style: TextStyle(decoration: TextDecoration.none),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: minutes.toString().padLeft(2, '0'),
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          fontSize: 60.0,
                          color: primary800,
                        ),
                      ),
                      TextSpan(
                        text: 'm ',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 35.0,
                          color: primary800,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: seconds.toString().padLeft(2, '0'),
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          fontSize: 60.0,
                          color: primary800,
                        ),
                      ),
                      TextSpan(
                        text: 's',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 35.0,
                          color: primary800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            DigitsKeyboard(onDigitTap: digitTapped)
          ],
        ),
      ),
    );
  }
}
