
import 'package:flutter/material.dart';

import 'package:hiitimer/theme.dart';
import 'package:hiitimer/workout_config.dart';


const List<WorkoutConfig> cfgs = [
  WorkoutConfig(
    name: 'TABATA/HIIT',
    blocks: [
      TimerBlock(phases: [20, 10], rounds: 7),
      TimerBlock(phases: [20], rounds: 1),
    ],
  ),
  WorkoutConfig(
    name: 'EMOM',
    blocks: [
      TimerBlock(phases: [60, 60, 60], rounds: 5),
    ],
  ),
  WorkoutConfig(
    name: 'wod_05092509270',
    blocks: [
      TimerBlock(phases: [10], rounds: 1),
      TimerBlock(phases: [5], rounds: 2),
      TimerBlock(phases: [3], rounds: 1),
    ],
  ),
  // WorkoutConfig(
  //   name: 'TABATA',
  //   blocks: [
  //     TimerBlock(phases: [20, 10], rounds: 7),
  //     TimerBlock(phases: [20], rounds: 1),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'E1MOM',
  //   blocks: [
  //     TimerBlock(phases: [60, 60, 60], rounds: 5),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'wod_05092509270',
  //   blocks: [
  //     TimerBlock(phases: [10], rounds: 1),
  //     TimerBlock(phases: [5], rounds: 2),
  //     TimerBlock(phases: [3], rounds: 1),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'TABATA',
  //   blocks: [
  //     TimerBlock(phases: [20, 10], rounds: 7),
  //     TimerBlock(phases: [20], rounds: 1),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'E1MOM',
  //   blocks: [
  //     TimerBlock(phases: [60, 60, 60], rounds: 5),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'wod_05092509270',
  //   blocks: [
  //     TimerBlock(phases: [10], rounds: 1),
  //     TimerBlock(phases: [5], rounds: 2),
  //     TimerBlock(phases: [3], rounds: 1),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'TABATA',
  //   blocks: [
  //     TimerBlock(phases: [20, 10], rounds: 7),
  //     TimerBlock(phases: [20], rounds: 1),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'E1MOM',
  //   blocks: [
  //     TimerBlock(phases: [60, 60, 60], rounds: 5),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'wod_05092509270',
  //   blocks: [
  //     TimerBlock(phases: [10], rounds: 1),
  //     TimerBlock(phases: [5], rounds: 2),
  //     TimerBlock(phases: [3], rounds: 1),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'TABATA',
  //   blocks: [
  //     TimerBlock(phases: [20, 10], rounds: 7),
  //     TimerBlock(phases: [20], rounds: 1),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'E1MOM',
  //   blocks: [
  //     TimerBlock(phases: [60, 60, 60], rounds: 5),
  //   ],
  // ),
  // WorkoutConfig(
  //   name: 'wod_05092509270',
  //   blocks: [
  //     TimerBlock(phases: [10], rounds: 1),
  //     TimerBlock(phases: [5], rounds: 2),
  //     TimerBlock(phases: [3], rounds: 1),
  //   ],
  // ),
];


class TimerSelector extends StatelessWidget {
  const TimerSelector({super.key, required this.showTimerConfig});

  final Function showTimerConfig;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return ListView(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight, // occupe tout l’écran
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end, // aligne en bas
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 20.0, top: 5.0),
                            decoration: BoxDecoration(
                              color: primary900.withAlpha(220),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 20.0),
                                  child: Text(
                                    'Choisis ton timer',
                                    style: TextStyle(
                                        fontFamily: 'BalooTamma2',
                                        fontSize: 28,
                                        fontWeight: FontWeight.w500,
                                        color: primary400),
                                  ),
                                ),
                                ...cfgs.map(
                                  (cfg) => Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: GestureDetector(
                                      onTap: () =>
                                          // _launchChrono(context, cfg),
                                          showTimerConfig(cfg),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                            color: primary800.withAlpha(150),
                                            border: const Border(
                                              top: BorderSide(
                                                  color: primary700, width: 1.0),
                                              bottom: BorderSide(
                                                  color: primary900, width: 2.0),
                                            )),
                                        child: Text(
                                          cfg.name,
                                          style: TextStyle(
                                              fontFamily: 'BalooTamma2',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900,
                                              color: primary200),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}