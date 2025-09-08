import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:hiitimer/theme.dart';
import 'package:hiitimer/timer_config_phase.dart';
import 'package:hiitimer/timer_config_rounds.dart';
import 'package:hiitimer/workout_config.dart';

class TimerConfigBlock extends StatefulWidget {
  const TimerConfigBlock({super.key, required this.index, required this.block});

  final int index;
  final TimerBlock block;

  @override
  State<TimerConfigBlock> createState() => _TimerConfigBlockState();
}

class _TimerConfigBlockState extends State<TimerConfigBlock> {
  List<int> _phases = [];

  @override
  void initState() {
    super.initState();

    _phases = [...widget.block.phases];
  }

  removePhase(int index, BuildContext context) {
    if (_phases.length > 1) {
     setState(() {
       _phases = _phases.asMap().entries.where((entry) => entry.key != index).map((entry) => entry.value).toList();
     }); 
    }
    else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Suppression impossible"),
          content: const Text(
            "Un bloc doit contenir au moins une phase. "
            "Vous ne pouvez pas supprimer la dernière phase.",
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

  addPhase(int index) {
    final phase = _phases.asMap().entries.where((entry) => entry.key == index).first.value;
    
    setState(() {
      _phases = [
        ..._phases.sublist(0,index+1),
        phase,
        ..._phases.sublist(index+1)
      ];
    });
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
                  'Bloc${widget.index + 1}',
                  style: TextStyle(
                    fontFamily: 'BalooTamma2',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: primary400,
                  ),
                ),
              ),
              ..._phases.asMap().entries.map((entry) {
                return TimerConfigPhase(
                  index: entry.key,
                  count: entry.value,
                  onAddPhase: addPhase,
                  onRemovePhase: (index) => removePhase(index, context),
                );
              }),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: TimerConfigRounds(
                    rounds: widget.block.rounds,
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
                          onPressed: () {},
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
                onPressed: () {},
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
