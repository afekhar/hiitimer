
import 'package:flutter/material.dart';

import 'package:hiitimer/theme.dart';
import 'package:hiitimer/workout_config.dart';
import 'package:hiitimer/timer_config_block.dart';


class TimerConfigDialog extends StatelessWidget {
  const TimerConfigDialog(
      {super.key, required this.timerConfig, required this.onClose});

  final WorkoutConfig? timerConfig;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    if (timerConfig == null) {
      return SizedBox.shrink();
    }

    return Container(
      color: primary800.withAlpha(75),
      padding: EdgeInsets.all(20.0),
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: primary950,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: primary700),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.0, top: 20.0, right: 80.0),
                    child: Text(
                      timerConfig!.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'BalooTamma2',
                          fontWeight: FontWeight.w600,
                          fontSize: 30.0,
                          color: primary100),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Expanded(
                      child: ListView(
                    children: timerConfig!.blocks
                        .asMap()
                        .entries
                        .map((entry) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 15.0),
                              child: TimerConfigBlock(
                                  index: entry.key, block: entry.value),
                            ))
                        .toList(),
                  ))
                ],
              ),
            ),
            Positioned(
              top: 15.0,
              right: 15.0,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: primary300.withAlpha(75),
                child: IconButton(
                  onPressed: onClose,
                  icon: const Icon(
                    Icons.close,
                    size: 15.0,
                    color: primary50,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

