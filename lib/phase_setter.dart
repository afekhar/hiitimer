import 'package:flutter/material.dart';

import 'package:hiitimer/theme.dart';

enum DigitKey {
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  doubeZero,
  backspace,
  cancel,
  ok
}

DigitKey? numToDigitKey(String value) {
  assert(value.length == 1 && int.tryParse(value) != null,
      'value must be a single digit 0–9');

  if (value == '0') {
    return DigitKey.zero;
  }

  if (value == '0') {
    return DigitKey.zero;
  }

  if (value == '1') {
    return DigitKey.one;
  }

  if (value == '2') {
    return DigitKey.two;
  }

  if (value == '3') {
    return DigitKey.three;
  }

  if (value == '4') {
    return DigitKey.four;
  }

  if (value == '5') {
    return DigitKey.five;
  }

  if (value == '6') {
    return DigitKey.six;
  }

  if (value == '7') {
    return DigitKey.seven;
  }

  if (value == '8') {
    return DigitKey.eight;
  }

  if (value == '9') {
    return DigitKey.nine;
  }

  return null;
}

int keyToNum(DigitKey key) {
  assert(
      [
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
      ].contains(key),
      'key must be a number.');

  if (key == DigitKey.zero) {
    return 0;
  }

  if (key == DigitKey.one) {
    return 1;
  }

  if (key == DigitKey.two) {
    return 2;
  }

  if (key == DigitKey.three) {
    return 3;
  }

  if (key == DigitKey.four) {
    return 4;
  }

  if (key == DigitKey.five) {
    return 5;
  }

  if (key == DigitKey.six) {
    return 6;
  }

  if (key == DigitKey.seven) {
    return 7;
  }

  if (key == DigitKey.eight) {
    return 8;
  }

  if (key == DigitKey.nine) {
    return 9;
  }

  return -1;
}

class PhaseDigit extends StatelessWidget {
  const PhaseDigit({super.key, required this.child, required this.onDigitTap});

  final Widget child;
  final Function onDigitTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onDigitTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          height: 65.0,
          width: 65.0,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: primary700,
          ),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}

class PhaseSetter extends StatefulWidget {
  const PhaseSetter(
      {super.key,
      required this.count,
      required this.onCancel,
      required this.onOK});

  final int count;
  final Function onCancel;
  final Function(int) onOK;

  @override
  State<PhaseSetter> createState() => _PhaseSetterState();
}

class _PhaseSetterState extends State<PhaseSetter> {
  int _ms = -1;

  digitTapped(DigitKey code) {
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
      final int ms =
          (code == DigitKey.doubeZero) ? _ms * 100 : _ms * 10 + keyToNum(code);

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
            title: const Text("Format de temps invalide."),
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

  @override
  void initState() {
    super.initState();

    int seconds = widget.count % 60;
    int minutes = widget.count ~/ 60;

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
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...['1', '2', '3'].map(
                      (digit) => PhaseDigit(
                        onDigitTap: () => digitTapped(numToDigitKey(digit)!),
                        child: Text(
                          digit,
                          style: TextStyle(
                              color: primary50,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                              fontSize: 25.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...['4', '5', '6'].map(
                      (digit) => PhaseDigit(
                        onDigitTap: () => digitTapped(numToDigitKey(digit)!),
                        child: Text(
                          digit,
                          style: TextStyle(
                              color: primary50,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                              fontSize: 25.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...['7', '8', '9'].map(
                      (digit) => PhaseDigit(
                        onDigitTap: () => digitTapped(numToDigitKey(digit)!),
                        child: Text(
                          digit,
                          style: TextStyle(
                              color: primary50,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                              fontSize: 25.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PhaseDigit(
                      onDigitTap: () => digitTapped(DigitKey.doubeZero),
                      child: Text(
                        '00',
                        style: TextStyle(
                            color: primary50,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            fontSize: 25.0),
                      ),
                    ),
                    PhaseDigit(
                      onDigitTap: () => digitTapped(DigitKey.zero),
                      child: Text(
                        '0',
                        style: TextStyle(
                            color: primary50,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            fontSize: 25.0),
                      ),
                    ),
                    PhaseDigit(
                      onDigitTap: () => digitTapped(DigitKey.backspace),
                      child: const Icon(
                        Icons.backspace,
                        size: 25.0,
                        color: primary50,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PhaseDigit(
                  onDigitTap: () => digitTapped(DigitKey.cancel),
                  child: const Icon(
                    Icons.close,
                    size: 35.0,
                    color: primary400,
                  ),
                ),
                PhaseDigit(
                  onDigitTap: () => digitTapped(DigitKey.ok),
                  child: const Icon(
                    Icons.check,
                    size: 35.0,
                    color: primary400,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
