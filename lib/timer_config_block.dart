import 'package:flutter/material.dart';

import 'package:hiitimer/theme.dart';
import 'package:hiitimer/timer_config_phase.dart';
import 'package:hiitimer/timer_config_rounds.dart';
import 'package:hiitimer/workout_config.dart';

class TimerConfigBlock extends StatelessWidget {
  const TimerConfigBlock(
      {super.key,
      required this.index,
      required this.block,
      required this.onBlockChange,
      required this.onAddBlock,
      required this.onRemoveBlock});

  final int index;
  final TimerBlock block;

  final Function(int index, TimerBlock block) onBlockChange;
  final Function(int index) onAddBlock;
  final Function(int index) onRemoveBlock;

  removePhase(int phaseIndex, BuildContext context) {
    final newBlock = TimerBlock(
      intervals: block.intervals
          .asMap()
          .entries
          .where((e) => e.key != phaseIndex)
          .map((e) => e.value)
          .toList(),
      rounds: block.rounds,
    );

    if (block.intervals.length > 1) {
      onBlockChange(
        index,
        newBlock,
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Suppression impossible"),
          content: const Text(
            "Un bloc doit contenir au moins un intervalle.",
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

  addPhase(int phaseIndex) {
    final newPhase = block.intervals
        .asMap()
        .entries
        .where((entry) => entry.key == phaseIndex)
        .first
        .value;

    final newBlock = TimerBlock(
      intervals: [
        ...block.intervals.sublist(0, phaseIndex + 1),
        newPhase,
        ...block.intervals.sublist(phaseIndex + 1),
      ],
      rounds: block.rounds,
    );

    onBlockChange(
      index,
      newBlock,
    );
  }

  phaseChanged(int phaseIndex, int count) {

    final changedBlock = TimerBlock(
      intervals: [
        ...block.intervals.sublist(0, phaseIndex),
        count,
        ...block.intervals.sublist(phaseIndex + 1),
      ],
      rounds: block.rounds,
    );

    onBlockChange(
      index,
      changedBlock,
    );
  }

  roundsChanged(int phaseIndex, int rounds) {

    final changedBlock = TimerBlock(
      intervals: [
        ...block.intervals,
      ],
      rounds: rounds,
    );

    onBlockChange(
      index,
      changedBlock,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: primary800,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Bloc ${index + 1}',
                  style: TextStyle(
                    fontFamily: 'BalooTamma2',
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                    color: primary400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Intervalles :',
                  style: TextStyle(
                    fontFamily: 'BalooTamma2',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: primary400,
                  ),
                ),
              ),
              ...block.intervals.asMap().entries.map((entry) {
                return TimerConfigPhase(
                  index: entry.key,
                  count: entry.value,
                  onAddPhase: addPhase,
                  onRemovePhase: (index) => removePhase(index, context),
                  onPhaseChange: (index, count) => phaseChanged(index, count),
                );
              }),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: TimerConfigRounds(
                    rounds: block.rounds,
                    onRoundsChange: (rounds) => roundsChanged(index, rounds),
                  ),
                ),
              ),
              SizedBox(
                height: 80.0,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundColor: primary300.withAlpha(75),
                        child: IconButton(
                          onPressed: () => onAddBlock(index),
                          icon: const Icon(
                            Icons.add,
                            size: 25.0,
                            color: primary950,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 10.0,
            right: 10.0,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: primary300.withAlpha(75),
              child: IconButton(
                onPressed: () => onRemoveBlock(index),
                icon: const Icon(
                  Icons.close,
                  size: 15.0,
                  color: primary950,
                ),
                padding: EdgeInsets.zero,
              ),
            ),
          )
        ],
      ),
    );
  }
}
