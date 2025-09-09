import 'package:flutter/material.dart';

import 'package:hiitimer/theme.dart';

class PhaseDigit extends StatelessWidget {
  const PhaseDigit({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class PhaseSetter extends StatelessWidget {
  const PhaseSetter({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    int seconds = count % 60;
    int minutes = count ~/ 60;

    return Column(
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
                PhaseDigit(
                  child: Text(
                    '1',
                    style: TextStyle(color: primary50, fontSize: 25.0),
                  ),
                ),
                PhaseDigit(
                  child: Text(
                    '2',
                    style: TextStyle(color: primary50, fontSize: 25.0),
                  ),
                ),
                PhaseDigit(
                  child: Text(
                    '3',
                    style: TextStyle(color: primary50, fontSize: 25.0),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PhaseDigit(
                  child: Text(
                    '4',
                    style: TextStyle(color: primary50, fontSize: 25.0),
                  ),
                ),
                PhaseDigit(
                  child: Text(
                    '5',
                    style: TextStyle(color: primary50, fontSize: 25.0),
                  ),
                ),
                PhaseDigit(
                  child: Text(
                    '6',
                    style: TextStyle(color: primary50, fontSize: 25.0),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PhaseDigit(
                  child: Text(
                    '7',
                    style: TextStyle(color: primary50, fontSize: 25.0),
                  ),
                ),
                PhaseDigit(
                  child: Text(
                    '8',
                    style: TextStyle(color: primary50, fontSize: 25.0),
                  ),
                ),
                PhaseDigit(
                  child: Text(
                    '9',
                    style: TextStyle(color: primary50, fontSize: 25.0),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PhaseDigit(
                  child: Text(
                    '00',
                    style: TextStyle(color: primary50, fontSize: 25.0),
                  ),
                ),
                PhaseDigit(
                  child: Text(
                    '0',
                    style: TextStyle(color: primary50, fontSize: 25.0),
                  ),
                ),
                PhaseDigit(
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
              child: const Icon(
                Icons.close,
                size: 35.0,
                color: primary400,
              ),
            ),
            PhaseDigit(
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
