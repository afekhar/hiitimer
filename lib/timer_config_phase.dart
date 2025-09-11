import 'package:flutter/material.dart';
import 'package:hiitimer/phase_setter.dart';

import 'package:hiitimer/theme.dart';

class TimerConfigPhase extends StatelessWidget {
  const TimerConfigPhase({
    super.key,
    required this.index,
    required this.count,
    required this.onAddPhase,
    required this.onRemovePhase,
    required this.onPhaseChange,
  });

  final int index;
  final int count;
  final Function(int index) onAddPhase;
  final Function(int index) onRemovePhase;
  final Function(int index, int count) onPhaseChange;

  @override
  Widget build(BuildContext context) {
    final int seconds = count % 60;
    final int minutes = count ~/ 60;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      child: Container(
        width: double.infinity,
        height: 60.0,
        decoration: BoxDecoration(
          color: primary700,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: primary300.withAlpha(75),
                child: IconButton(
                  onPressed: () => onAddPhase(index),
                  icon: const Icon(
                    Icons.add,
                    size: 15.0,
                    color: primary50,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: primary200,
                    isScrollControlled: true, // Necessary to avoid the error: BOTTOM OVERFLOW BY XX PIXELS
                    builder: (context) => SafeArea(
                      top: false,
                      child: IntrinsicHeight( // Makes the bottom sheet fit its content height
                        child: PhaseSetter(
                          count: count,
                          onCancel: () => Navigator.of(context).pop(),
                          onOK: (newCount) {
                            onPhaseChange(index, newCount);
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  height: double.infinity,
                  child: Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: minutes.toString().padLeft(2, '0'),
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w600,
                                fontSize: 25.0,
                                color: primary200,
                              ),
                            ),
                            TextSpan(
                              text: 'm ',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 20.0,
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
                                fontSize: 25.0,
                                color: primary200,
                              ),
                            ),
                            TextSpan(
                              text: 's',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 20.0,
                                color: primary200,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 12,
                backgroundColor: primary300.withAlpha(75),
                child: IconButton(
                  onPressed: () => onRemovePhase(index),
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
