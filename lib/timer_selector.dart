import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:hiitimer/theme.dart';
import 'package:hiitimer/workout_config.dart';

class TimerSelector extends StatefulWidget {
  const TimerSelector({super.key, required this.showTimerConfig});

  final Function showTimerConfig;

  @override
  State<TimerSelector> createState() => _TimerSelectorState();
}

class _TimerSelectorState extends State<TimerSelector> {
  List<WorkoutConfig>? _cfgs;

  _loadConfigs() async {
    List<WorkoutConfig> cfgs = [
      WorkoutConfig(
        name: 'TABATA/HIIT',
        blocks: [
          TimerBlock(intervals: [20, 10], rounds: 7),
          TimerBlock(intervals: [20], rounds: 1),
        ],
      ),
      WorkoutConfig(
        name: 'EMOM',
        blocks: [
          TimerBlock(intervals: [60, 60, 60, 60], rounds: 3),
        ],
      ),
    ];

    final box = Hive.box<WorkoutConfig>('timers');
    final entries = box.toMap().cast<String, WorkoutConfig>().entries.toList()
      ..sort((a, b) => a.value.createdAt.compareTo(b.value.createdAt));

    cfgs = [
      ...cfgs,
      ...entries.map(
          (entry) => WorkoutConfig(name: entry.key, blocks: entry.value.blocks))
    ];

    setState(() {
      _cfgs = cfgs;
    });
  }

  @override
  void initState() {
    super.initState();

    _loadConfigs();
  }

  @override
  Widget build(BuildContext context) {
    if (_cfgs == null) {
      return Center(
        child: CircularProgressIndicator(), // Default spinner
      );
    }

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
                                left: 10.0,
                                right: 10.0,
                                bottom: 20.0,
                                top: 5.0),
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
                                ..._cfgs!.map(
                                  (cfg) => Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: GestureDetector(
                                      onTap: () =>
                                          // _launchChrono(context, cfg),
                                          widget.showTimerConfig(cfg),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                            color: primary800.withAlpha(150),
                                            border: const Border(
                                              top: BorderSide(
                                                  color: primary700,
                                                  width: 1.0),
                                              bottom: BorderSide(
                                                  color: primary900,
                                                  width: 2.0),
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
