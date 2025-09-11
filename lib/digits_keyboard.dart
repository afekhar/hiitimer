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

class KeyboardDigit extends StatelessWidget {
  const KeyboardDigit(
      {super.key, required this.child, required this.onDigitTap});

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

class DigitsKeyboard extends StatelessWidget {
  const DigitsKeyboard({super.key, this.doubleZero = true, required this.onDigitTap});

  final bool doubleZero;
  final Function(DigitKey?) onDigitTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...['1', '2', '3'].map(
                  (digit) => KeyboardDigit(
                    onDigitTap: () => onDigitTap(numToDigitKey(digit)!),
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
                  (digit) => KeyboardDigit(
                    onDigitTap: () => onDigitTap(numToDigitKey(digit)!),
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
                  (digit) => KeyboardDigit(
                    onDigitTap: () => onDigitTap(numToDigitKey(digit)!),
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
                doubleZero ?
                KeyboardDigit(
                  onDigitTap: () => onDigitTap(DigitKey.doubeZero),
                  child: Text(
                    '00',
                    style: TextStyle(
                        color: primary50,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        fontSize: 25.0),
                  ),
                ) : SizedBox(
                  height: 65.0,
                  width: 70.0,
                ),
                KeyboardDigit(
                  onDigitTap: () => onDigitTap(DigitKey.zero),
                  child: Text(
                    '0',
                    style: TextStyle(
                        color: primary50,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        fontSize: 25.0),
                  ),
                ),
                KeyboardDigit(
                  onDigitTap: () => onDigitTap(DigitKey.backspace),
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
            KeyboardDigit(
              onDigitTap: () => onDigitTap(DigitKey.cancel),
              child: const Icon(
                Icons.close,
                size: 35.0,
                color: primary400,
              ),
            ),
            KeyboardDigit(
              onDigitTap: () => onDigitTap(DigitKey.ok),
              child: const Icon(
                Icons.check,
                size: 35.0,
                color: primary400,
              ),
            ),
          ],
        )
      ],
    );
  }
}
