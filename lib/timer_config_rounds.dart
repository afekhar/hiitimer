
import 'package:flutter/material.dart';

import 'package:hiitimer/theme.dart';

class TimerConfigRounds extends StatelessWidget {
  const TimerConfigRounds({super.key, required this.rounds});

  final int rounds;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

