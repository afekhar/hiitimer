
import 'package:flutter/material.dart';

import 'package:hiitimer/theme.dart';

class TimerConfigPhase extends StatelessWidget {
  const TimerConfigPhase({super.key, required this.index, required this.count});

  final int index;
  final int count;

  @override
  Widget build(BuildContext context) {
    final seconds = count % 60;
    final minutes = count ~/ 60;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      child: Container(
        width: double.infinity,
        height: 40.0,
        decoration: BoxDecoration(
          color: primary700,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: primary300.withAlpha(75),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                    size: 15.0,
                    color: primary50,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Phase${index + 1}:',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: primary400,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: minutes.toString().padLeft(2, '0'),
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                            color: primary200,
                          ),
                        ),
                        TextSpan(
                          text: 'm ',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0,
                            color: primary200,
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
                            fontSize: 20.0,
                            color: primary200,
                          ),
                        ),
                        TextSpan(
                          text: 's',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0,
                            color: primary200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 12,
                backgroundColor: primary300.withAlpha(75),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close,
                    size: 15.0,
                    color: primary50,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

