import 'package:flutter/material.dart';

import 'package:hiitimer/digits_keyboard.dart';
import 'package:hiitimer/theme.dart';

class RoundsSetter extends StatefulWidget {
  const RoundsSetter({
    super.key,
    required this.rounds,
    required this.onCancel,
    required this.onOK,
  });

  final int rounds;
  final Function onCancel;
  final Function(int) onOK;

  @override
  State<RoundsSetter> createState() => _RoundsSetterState();
}

class _RoundsSetterState extends State<RoundsSetter> {
  int _rounds = 0;

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
      ].contains(code)) {
        final rounds = (_rounds * 10) + keyToNum(code);
        if (rounds <= 99) {
          setState(() {
            _rounds = rounds;
          });
        }
      } else if (code == DigitKey.backspace) {
        setState(() {
          _rounds = _rounds ~/ 10;
        });
      } else if (code == DigitKey.cancel) {
        widget.onCancel();
      } else if (code == DigitKey.ok) {
        if (_rounds != 0) {
          widget.onOK(_rounds);
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Nombre de rounds invalide"),
              content: const Text("Un bloc doit contenir au moins un round. "
                  "Veuillez saisir une valeur supérieure à zéro."),
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

    _rounds = widget.rounds;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'x',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                    color: primary600,
                  ),
                ),
                TextSpan(
                  text: '$_rounds',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 60.0,
                    fontWeight: FontWeight.w900,
                    color: primary900,
                  ),
                ),
                TextSpan(
                  text: ' rounds',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                    color: primary600,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: DigitsKeyboard(
              doubleZero: false, onDigitTap: (key) => digitTapped(key)),
        )
      ],
    );
  }
}
